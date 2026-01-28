<?php

namespace app\api\controller;

use app\api\validate\TicketUser as TicketUserValidate;
use app\common\controller\Api;
use Throwable;
use ba\Captcha;
use think\facade\Config;
use app\common\facade\Token;
use app\admin\model\ticketuser\TicketUser as TicketUserModel;
class TicketUser extends Api
{

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
//            $params = $this->request->post(['phone', 'password', 'captcha']);
            $params = $this->request->post(['phone', 'password','captcha']);

            // 验证参数
            $validate = new TicketUserValidate();
            try {
                $validate->scene('login')->check($params);
            } catch (Throwable  $e) {
                $this->error($e->getMessage());
            }

//            // 验证码校验（默认开启）
//            $captchaObj = new Captcha();
//            // 使用手机号作为验证码标识
//            if (!$captchaObj->check($params['captcha'], $params['phone'] . '_ticket_user_login')) {
//                $this->error(__('验证码错误'));
//            }

            // 查询用户
            $user = TicketUserModel::where('phone', $params['phone'])
                ->where('status', 1) // 只允许已审核用户登录
                ->find();

            if (!$user || !password_verify($params['password'], $user->password_hash)) {
                $this->error(__('Invalid phone or password'));
            }

            // 生成 token
            $tokenData = [
                'id' => $user->id,
                'phone' => $user->phone,
                'role' => $user->role,
            ];

            return '234343';

//            $accessToken = Token::create($tokenData, 'ticket_user');
//            $refreshToken = Token::create($tokenData, 'ticket_user_refresh', Config::get('jwt.refresh_ttl', 604800));
//
//            $this->success(__('Login succeeded!'), [
//                'userInfo' => [
//                    'id' => $user->id,
//                    'phone' => $user->phone,
//                    'email' => $user->email,
//                    'avatar' => $user->avatar,
//                    'gender' => $user->gender,
//                    'role' => $user->role,
//                ],
//                'accessToken' => $accessToken,
//                'refreshToken' => $refreshToken,
//            ]);
        }

        $this->error(__('Invalid request method'));
    }

    /**
     * 注册
     */
    public function register()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post(['phone', 'password', 'email', 'captcha']);

            $validate = new TicketUserValidate();
            try {
                $validate->scene('register')->check($params);
            } catch (Throwable  $e) {
                $this->error($e->getMessage());
            }

            // 验证码校验
            $captchaObj = new Captcha();
            if (!$captchaObj->check($params['captcha'], $params['phone'] . 'ticket_user_register')) {
                $this->error(__('Please enter the correct verification code'));
            }

            // 检查手机号是否已存在
            if (TicketUserModel::where('phone', $params['phone'])->find()) {
                $this->error(__('Phone number already registered'));
            }

            // 创建用户（默认 status=0 待审核）
            $user = new TicketUserModel();
            $user->phone = $params['phone'];
            $user->password_hash = password_hash($params['password'], PASSWORD_DEFAULT);
            $user->email = $params['email'] ?? '';
            $user->status = 0; // 待审核
            $user->role = 0; // 普通用户
            $user->created_at = date('Y-m-d H:i:s');
            $user->updated_at = date('Y-m-d H:i:s');

            if ($user->save()) {
                $this->success(__('Registration successful, please wait for admin approval'));
            } else {
                $this->error(__('Registration failed'));
            }
        }

        $this->error(__('Invalid request method'));
    }

    /**
     * 登出
     */
    public function logout()
    {
        if ($this->request->isPost()) {
            $refreshToken = $this->request->post('refreshToken', '');
            if ($refreshToken) {
                Token::delete((string)$refreshToken);
            }
            // accessToken 由前端丢弃即可，后端无状态
            $this->success();
        }
        $this->error(__('Invalid request method'));
    }
}