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
     * 创建用户（带详情）
     * @param array $userData 用户数据
     * @param array $profileData 详情数据
     * @return TicketUser|false
     */
    public static function createWithProfile(array $userData, array $profileData)
    {
        try {
            // 开始事务
            self::startTrans();

            // 创建主用户
            $user = self::create([
                'phone' => $userData['phone'],
                'password_hash' => hash_password($userData['password']),
                'email' => $userData['email'] ?? null,
                'gender' => $userData['gender'] ?? 0,
                'status' => 1, // 或根据需求设为0（待审核）
                'role' => 0,
            ]);

            if (!$user) {
                throw new \Exception('用户创建失败');
            }

            // 创建用户详情
            $profile = UserProfile::create([
                'user_id' => $user->id,
                'real_name' => $profileData['real_name'],
                'account_name' => $profileData['account_name'],
                'wechat_id' => $profileData['wechat_id'] ?? '',
            ]);

            if (!$profile) {
                throw new \Exception('用户详情创建失败');
            }

            // 提交事务
            self::commit();

            return $user;

        } catch (\Exception $e) {
            // 回滚事务
            self::rollback();
            return false;
        }
    }


}