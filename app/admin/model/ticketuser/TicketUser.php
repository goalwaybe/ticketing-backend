<?php

namespace app\admin\model\ticketuser;

use think\Model;

/**
 * TicketUser
 */
class TicketUser extends Model
{
    // 表名
    protected $name = 'ticket_user';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;


    /**
     * 关联用户详情表
     */
    public function profile()
    {
        return $this->hasOne(UserProfile::class, 'user_id', 'id');
    }


    /**
     * 重置用户密码
     * @param int|string $uid 管理员ID
     * @param string $newPassword 新密码
     * @return int|TicketUser
     */
    public function resetPassword(int|string $uid, string $newPassword): int|TicketUser
    {
        return $this->
        where(['id' => $uid])->
        update([
            'password_hash' => hash_password($newPassword),
        ]);
    }


    /**
     * 创建用户（带详情） - 更新版
     * @param array $userData 用户数据
     * @param array $profileData 详情数据
     * @return TicketUser|false
     */
    public static function createWithProfile(array $userData, array $profileData)
    {
        // 创建主用户
        $user = self::create([
            'phone' => $userData['phone'],
            'password_hash' => hash_password($userData['password']),
            'email' => $userData['email'] ?? null,
            'gender' => $userData['gender'] ?? 0,
            'status' => $userData['status'] ?? 0, // 注册时默认为0（待审核）
            'role' => 0, // 普通用户
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ]);

        if (!$user) {
            throw new \Exception('用户创建失败');
        }

        // 创建用户详情
        $profile = UserProfile::create([
            'user_id' => $user->id,
            'real_name' => $profileData['real_name'] ?? '',
            'account_name' => $profileData['account_name'] ?? $profileData['real_name'] ?? '',
            'wechat_id' => $profileData['wechat_id'] ?? '',
            'bank_card_no' => $profileData['bank_card_no'] ?? '',
            'bank_name' => $profileData['bank_name'] ?? '',
            'id_card_no' => $profileData['id_card_no'] ?? '',
            'id_card1_image' => $profileData['id_card1_image'] ?? '',
            'id_card2_image' => $profileData['id_card2_image'] ?? '',
            'alipay_qr_image' => $profileData['alipay_qr_image'] ?? '',
            'wechat_qr_image' => $profileData['wechat_qr_image'] ?? '',
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ]);

        if (!$profile) {
            // 如果详情创建失败，删除已创建的用户
            self::where('id', $user->id)->delete();
            return false;
        }
        return $user;
    }


}