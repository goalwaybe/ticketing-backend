<?php

namespace app\api\validate;

use think\Validate;
use think\facade\Config;

class TicketUser extends Validate
{
    protected $failException = true;

    protected $rule = [
        'phone' => 'require|mobile',
        'password' => 'require|regex:^(?!.*[&<>"\'\n\r]).{6,32}$',
        'password_confirm' => 'require|confirm:password',
        'captcha' => 'require',
        'email' => 'email',
        'gender' => 'in:0,1,2',
        // 注册时需要填写的信息
        'real_name' => 'require|chs|length:2,20',
        'account_name' => 'require|chs|length:2,20',
        'wechat_id' => 'max:100',
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'register' => ['phone', 'password', 'password_confirm', 'captcha', 'real_name', 'account_name', 'wechat_id'],
        'login' => [], // 动态场景在 sceneLogin 方法中定义
        'update_profile' => ['real_name', 'account_name', 'wechat_id', 'email', 'gender'],
    ];

    /**
     * 注册验证场景
     */
    public function sceneRegister(): TicketUser
    {
        return $this->only(['phone', 'password', 'password_confirm', 'captcha', 'real_name', 'account_name', 'wechat_id'])
            ->append('phone', 'unique:ticket_user');
    }


    /**
     * 登录验证场景
     */
    public function sceneLogin(): TicketUser
    {
        $fields = ['phone', 'password'];

//        // 根据系统配置决定是否验证验证码
//        $captchaSwitch = Config::get('buildadmin.ticket_user_login_captcha', false);
//        if ($captchaSwitch) {
            $fields[] = 'captcha';
//        }

        return $this->only($fields);
    }

    /**
     * 更新个人信息场景
     */
    public function sceneUpdateProfile(): TicketUser
    {
        return $this->only(['real_name', 'account_name', 'wechat_id', 'email', 'gender']);
    }

    /**
     * 重置密码场景
     */
    public function sceneResetPassword(): TicketUser
    {
        return $this->only(['phone', 'password', 'password_confirm', 'captcha']);
    }


    public function __construct()
    {
        $this->field = [
            'phone' => __('手机号'),
            'password' => __('密码'),
            'password_confirm' => __('确认密码'),
            'captcha' => __('验证码'),
            'email' => __('邮箱'),
            'gender' => __('性别'),
            'real_name' => __('负责人姓名'),
            'account_name' => __('开户名'),
            'wechat_id' => __('微信号'),
        ];

        $this->message = array_merge($this->message, [
            'phone.require' => __('请输入手机号'),
            'phone.mobile' => __('请输入正确的手机号'),
            'phone.unique' => __('手机号已被注册'),
            'password.require' => __('请输入密码'),
            'password.regex' => __('密码格式不正确，长度为6-32位，不能包含特殊字符'),
            'password_confirm.require' => __('请输入确认密码'),
            'password_confirm.confirm' => __('两次输入的密码不一致'),
            'captcha.require' => __('请输入验证码'),
            'email.email' => __('请输入正确的邮箱地址'),
            'gender.in' => __('性别选择无效'),
            'real_name.require' => __('请输入负责人姓名'),
            'real_name.chs' => __('负责人姓名只能为中文'),
            'real_name.length' => __('负责人姓名长度为2-20个字符'),
            'account_name.require' => __('请输入开户名'),
            'account_name.chs' => __('开户名只能为中文'),
            'account_name.length' => __('开户名长度为2-20个字符'),
            'wechat_id.max' => __('微信号不能超过100个字符'),
        ]);

        parent::__construct();
    }

    /**
     * 自定义规则：检查手机号是否存在（用于登录验证）
     */
    protected function phoneExists($value)
    {
        // 使用模型检查手机号是否存在
        $model = \app\admin\model\ticketuser\TicketUser::where('phone', $value)
            ->where('deleted_at', null)
            ->count();

        return $model > 0;
    }
}