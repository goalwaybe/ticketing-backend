<?php

namespace app\api\controller;

use app\api\validate\TicketUser as TicketUserValidate;
use app\common\controller\Api;
use ba\Random;
use think\facade\Db;
use Throwable;
use ba\Captcha;
use think\facade\Config;
use app\common\facade\Token;
use app\admin\model\ticketuser\TicketUser as TicketUserModel;

class TicketUser extends Api
{

    /**
     * 令牌
     * @var string
     */
    protected string $token = '';

    /**
     * token 入库 type
     */
    public const TOKEN_TYPE = 'ticketUser';

    /**
     * 令牌默认有效期
     * 可在 config/buildadmin.php 内修改默认值
     * @var int
     */
    protected int $keepTime = 86400;

    /**
     * 不需要Token认证的路由列表
     * 格式: ['api/控制器名/方法名']
     * @var array
     */
    protected static array $noNeedAuth = [
        'api/ticketuser/register',    // 注册
        'api/ticketuser/login',       // 登录
        'api/ticketuser/checkIn',     // 登录
        'api/ticketuser/test',        // 测试
    ];

    /**
     * 登录
     */
    public function test()
    {
        // 直接返回测试
        return json([
            'code' => 1,
            'msg' => '测试成功',
            'data' => '12121'
        ]);
    }

    /**
     * 登录
     */
    public function checkIn()
    {

        if ($this->request->isPost()) {
            $params = $this->request->post(['phone', 'password', 'captcha','captcha_id']);

            // 验证参数
            $validate = new TicketUserValidate();
            try {
                $validate->scene('login')->check($params);
            } catch (Throwable  $e) {
                $this->error($e->getMessage());
            }


            $captchaId = $params['captcha_id'];

            // 验证码校验（默认开启）
            $captchaObj = new Captcha();
            // 使用手机号作为验证码标识
            if (!$captchaObj->check($params['captcha'], $captchaId)) {
                $this->error(__('验证码错误'));
            }

            // 查询用户
            $user = TicketUserModel::where('phone', $params['phone'])
                ->where('status', 1) // 只允许已审核用户登录
                ->find();

            if (!$user || !password_verify($params['password'], $user->password_hash)) {
                $this->error(__('Invalid phone or password'));
            }

            if (!$this->token) {
                $this->token = Random::uuid();
                Token::set($this->token, self::TOKEN_TYPE, $user->id, $this->keepTime);
            }

            $user->last_login_time = date('Y-m-d H:i:s');
            $user->last_login_ip = $this->request->ip();

            $user->save();

            $accessToken = $this->token;
//            $refreshToken = Token::create($tokenData, 'ticket_user_refresh', Config::get('jwt.refresh_ttl', 604800));

//            $refreshToken= (Common::class)->refreshToken();

            $this->success(__('Login succeeded!'), [
                'userInfo' => [
                    'id' => $user->id,
                    'phone' => $user->phone,
                    'email' => $user->email,
                    'avatar' => $user->avatar,
                    'gender' => $user->gender,
                    'role' => $user->role,
                ],
                'accessToken' => $accessToken,
//                'refreshToken' => $refreshToken,
            ]);
        }

        $this->error(__('Invalid request method'));
    }

    /**
     * 注册
     */
    public function register()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post([
                'phone',
                'password',
                'password_confirm',
                'email',
                'real_name',          // 负责人姓名
                'account_name',       // 开户名（新增）
                'wechat_id',          // 微信号（注意：字段名改为 wechat_id）
                'bank_card_no',       //银行账户
                'bank_name',          //开户行
                'id_card_no',         // 身份证号（新增）
                'id_card1_image',         // 身份证正面
                'id_card2_image',         // 身份证反面
                'alipay_qr_image',    // 支付宝收款码图片URL（注意：字段名改为 alipay_qr_image）
                'alipay_account',    // 支付宝账号
                'wechat_qr_image',    // 微信收款码图片URL（注意：字段名改为 wechat_qr_image）
                'captcha'
            ]);

            $validate = new TicketUserValidate();
            try {
//                $validate->scene('register')->check($params);
            } catch (Throwable  $e) {
                $this->error($e->getMessage());
            }

            // 验证码校验
//            $captchaObj = new Captcha();
//            if (!$captchaObj->check($params['captcha'], $params['phone'] . 'ticket_user_register')) {
//                $this->error(__('Please enter the correct verification code'));
//            }

            // 检查手机号是否已存在
            if (TicketUserModel::where('phone', $params['phone'])->find()) {
                $this->error(__('Phone number already registered'));
            }

            // 使用TicketUserModel作为事务管理模型
            $userModel = new TicketUserModel();

            // 开始事务
            // 使用Db门面开启事务
            $userModel::startTrans();
            try {
                // 准备用户数据
                $userData = [
                    'phone' => $params['phone'],
                    'password' => $params['password'],
                    'email' => $params['email'] ?? '',
                    'gender' => 0, // 默认未知
                    'status' => 0, // 待审核（根据PDF文档，注册后需要客服审核）
                ];

                // 准备用户详情数据
                $profileData = [
                    'real_name' => $params['real_name'] ?? '',
                    'account_name' => $params['account_name'] ?? $params['real_name'], // 开户名默认与负责人姓名一致
                    'wechat_id' => $params['wechat_id'] ?? '',
                    'bank_card_no' => $params['bank_card_no'] ?? '',
                    'bank_name' => $params['bank_name'] ?? '',          // 开户行
                    'id_card_no' => $params['id_card_no'] ?? '',
                    "id_card1_image" => $params['id_card1_image'] ?? '',
                    "id_card2_image" => $params['id_card2_image'] ?? '',
                    'alipay_qr_image' => $params['alipay_qr_image'] ?? '',
                    'alipay_account' => $params['alipay_account'] ?? '',
                    'wechat_qr_image' => $params['wechat_qr_image'] ?? '',
                ];

                // 调用模型的 createWithProfile 方法
                $result = TicketUserModel::createWithProfile($userData, $profileData);

                if (!$result) {
                    throw new \Exception(__('Registration failed'));
                }

                // 提交事务
                $userModel::commit();
            } catch (Throwable $e) {
                // 回滚事务
                $userModel::rollback();
                $this->error(__('用户注册失败: ') .  $e->getMessage() . ' Stack trace: ' .  $e->getTraceAsString());
            }
        }

        $this->success(__('注册成功，请等待管理员审核。'));
    }

    /**
     * 登出
     */
    public function logout()
    {
        if ($this->request->isPost()) {

            // 获取access token
            $accessToken = $this->getTokenFromRequest($this->request);

            if ($accessToken) {
                // 删除token
                $deleted = Token::delete($accessToken);
                if ($deleted) {
                    $this->success(__('Logout successful'));
                } else {
                    $this->success(__('Token already expired or deleted'));
                }
            } else {
                $this->error(__('Token not found in request'));
            }
        }
        $this->error(__('Invalid request method'));
    }


    /**
     * 获取用户资料
     */
    public function profile(): void
    {
        // 从请求中获取用户信息（由中间件设置）
        $ticketUser = $this->request->ticketUser;
        $ticketUserId = $this->request->ticketUserId;

        // 获取当前登录用户
        $user = TicketUserModel::where('id', $ticketUserId)
            ->where('deleted_at', null)
            ->find();

        if (!$user) {
            $this->error(__('User does not exist'));
        }

        $userInfo = [
            'id' => $user->id,
            'phone' => $user->phone,
            'email' => $user->email,
            'status' => $user->status,
            'role' => $user->role,
            'created_at' => $user->created_at,
        ];

        // 获取用户详情
        $profile = $user->profile;
        if ($profile) {
            $userInfo = array_merge($userInfo, [
                'real_name' => $profile->real_name,
                'account_name' => $profile->account_name,
                'wechat_id' => $profile->wechat_id,
                'bank_name' => $profile->bank_name,
                'bank_card_no' => $profile->bank_card_no,
                'id_card_no' => $profile->id_card_no ? '已填写' : '未填写', // 出于安全考虑，不返回完整身份证号
                'id_card1_image' => $profile->id_card1_image,
                'id_card2_image' => $profile->id_card2_image,
                'alipay_qr_image' => $profile->alipay_qr_image,
                'alipay_account' => $profile->alipay_account,
                'wechat_qr_image' => $profile->wechat_qr_image,
                'updated_at' => $profile->updated_at,
            ]);
        }

        $this->success('', $userInfo);
    }

    /**
     * 更新用户资料
     */
    public function updateProfile(): void
    {
        if ($this->request->isPost()) {
            $params = $this->request->post([
                'email',
                'real_name',
                'account_name',
                'wechat_id',
                'bank_card_no',     // 银行卡号（可修改）
                'alipay_qr_image',  // 支付宝收款码
                'wechat_qr_image',  // 微信收款码
            ]);

            // 数据验证
            $validate = new TicketUserValidate();
            try {
                $validate->scene('updateProfile')->check($params);
            } catch (Throwable $e) {
                $this->error($e->getMessage());
            }

            // 从请求中获取用户信息（由中间件设置）
            $ticketUserId = $this->request->ticketUserId;
            $currentUser = $this->request->ticketUser;

            if (!$currentUser || !$ticketUserId) {
                $this->error(__('User authentication required'), null, [], 401);
            }

            // 获取用户
            $user = TicketUserModel::where('id', $ticketUserId)
                ->where('deleted_at', null)
                ->find();

            if (!$user) {
                $this->error(__('User does not exist'));
            }

            // 开始事务
            $user->startTrans();
            try {
                // 更新用户主表
                if (isset($params['email'])) {
                    $user->email = $params['email'];
                    $user->updated_at = date('Y-m-d H:i:s');
                    $user->save();
                }

                // 更新用户详情
                $profile = $user->profile;
                if (!$profile) {
                    throw new \Exception(__('User profile does not exist'));
                }

                // 注意：PDF文档中提到 "不要改负责人"，所以real_name不能修改
                // 只更新允许修改的字段
                $updateData = [];
                if (isset($params['account_name'])) {
                    $updateData['account_name'] = $params['account_name'];
                }
                if (isset($params['wechat_id'])) {
                    $updateData['wechat_id'] = $params['wechat_id'];
                }
                if (isset($params['bank_card_no'])) {
                    $updateData['bank_card_no'] = $params['bank_card_no'];
                }
                if (isset($params['alipay_qr_image'])) {
                    $updateData['alipay_qr_image'] = $params['alipay_qr_image'];
                }
                if (isset($params['wechat_qr_image'])) {
                    $updateData['wechat_qr_image'] = $params['wechat_qr_image'];
                }

                if (!empty($updateData)) {
                    $updateData['updated_at'] = date('Y-m-d H:i:s');
                    $profile->save($updateData);
                }

                // 提交事务
                $user->commit();

                $this->success(__('Data updated successfully'));

            } catch (Throwable $e) {
                // 回滚事务
                $user->rollback();
                $this->error(__('Update failed: ') . $e->getMessage());
            }
        }

        $this->error(__('Invalid request method'));
    }


    /**
     * 从请求中获取Token（辅助方法）
     */
    private function getTokenFromRequest($request): ?string
    {
        $token = $request->header('Authorization');

        if (!$token) {
            $token = $request->param('token');
        }

        if ($token && stripos($token, 'Bearer ') === 0) {
            $token = substr($token, 7);
        }

        return $token ?: null;
    }


}