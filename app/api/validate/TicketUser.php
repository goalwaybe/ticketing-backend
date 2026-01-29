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
        'captcha_id' => 'require', // 新增：验证码标识
        'email' => 'email',
        'gender' => 'in:0,1,2',
        // 注册时需要填写的信息
        'real_name' => 'require|chs|length:2,20',
        'account_name' => 'require|chs|length:2,20',
        'wechat_id' => 'max:100',
        // 新增字段
        'id_card_no' => 'idCard', // 身份证号验证
        'bank_name' => 'max:100', // 开户行名称，允许中英文、括号、空格等
        'bank_card_no' => 'checkBankCard|max:19', // 银行账户
        'id_card1_image' => 'url|max:500', // 身份证正面图片URL
        'id_card2_image' => 'url|max:500', // 身份证反面图片URL
        'alipay_qr_image' => 'url|max:500', // 支付宝收款码图片URL
        'wechat_qr_image' => 'url|max:500', // 微信收款码图片URL
    ];

    /**
     * 验证场景
     */
    protected $scene = [
        'register' => ['phone', 'password', 'password_confirm', 'captcha', 'real_name', 'account_name', 'bank_card_no', 'bank_name', 'wechat_id', 'id_card_no', 'id_card1_image', 'id_card2_image', 'alipay_qr_image', 'wechat_qr_image'],
        'login' => [], // 动态场景在 sceneLogin 方法中定义
        'update_profile' => ['email', 'account_name', 'wechat_id', 'bank_card_no','bank_name', 'alipay_qr_image', 'wechat_qr_image'],
    ];

    /**
     * 注册验证场景
     */
    public function sceneRegister(): TicketUser
    {
        return $this->only(['phone', 'password', 'password_confirm', 'captcha', 'real_name', 'account_name', 'bank_card_no','bank_name', 'wechat_id', 'id_card_no', 'id_card1_image', 'id_card2_image', 'alipay_qr_image', 'wechat_qr_image'])
            ->append('phone', 'unique:ticket_user')
            // 身份证号和图片不是必填项，根据PDF文档可以放心填写但不是强制要求
            ->remove('id_card_no', 'require')
            ->remove('id_card1_image', 'require')
            ->remove('id_card2_image', 'require')
            ->remove('alipay_qr_image', 'require')
            ->remove('wechat_qr_image', 'require');
    }



    /**
     * 登录验证场景
     */
    public function sceneLogin(): TicketUser
    {
        $fields = ['phone', 'password'];

        // 根据系统配置决定是否验证验证码
        $captchaSwitch = Config::get('buildadmin.ticket_user_login_captcha', false);
        if ($captchaSwitch) {
            $fields[] = 'captcha';
            $fields[] = 'captcha_id'; // 添加验证码标识
        }

        return $this->only($fields);
    }

    /**
     * 更新个人信息场景
     */
    public function sceneUpdateProfile(): TicketUser
    {
        return $this->only(['email', 'account_name', 'wechat_id', 'bank_card_no','bank_name', 'alipay_qr_image', 'wechat_qr_image'])
            ->remove('email', 'require') // 邮箱不是必填
            ->remove('account_name', 'require') // 开户名不是必填
            ->remove('wechat_id', 'require') // 微信号不是必填
            ->remove('alipay_qr_image', 'require') // 支付宝收款码不是必填
            ->remove('wechat_qr_image', 'require'); // 微信收款码不是必填
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
            'captcha_id' => __('验证码标识'), // 新增字段
            'email' => __('邮箱'),
            'gender' => __('性别'),
            'real_name' => __('负责人姓名'),
            'account_name' => __('开户名'),
            'wechat_id' => __('微信号'),
            'id_card_no' => __('身份证号'),
            'id_card1_image' => __('身份证正面照片'),
            'id_card2_image' => __('身份证反面照片'),
            'bank_card_no' => __('银行卡号'),
            'bank_name' => __('开户银行'),
            'alipay_qr_image' => __('支付宝收款码'),
            'wechat_qr_image' => __('微信收款码'),
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
            'captcha_id.require' => __('验证码标识不能为空'), // 新增错误消息
            'email.email' => __('请输入正确的邮箱地址'),
            'gender.in' => __('性别选择无效'),
            'real_name.require' => __('请输入负责人姓名'),
            'real_name.chs' => __('负责人姓名只能为中文'),
            'real_name.length' => __('负责人姓名长度为2-20个字符'),
            'account_name.require' => __('请输入开户名'),
            'account_name.chs' => __('开户名只能为中文'),
            'account_name.length' => __('开户名长度为2-20个字符'),
            'wechat_id.max' => __('微信号不能超过100个字符'),
            // 新增字段的验证消息
            'id_card_no.idCard' => __('请输入正确的身份证号'),
            'id_card1_image.url' => __('身份证正面照片必须是有效的URL'),
            'id_card1_image.max' => __('身份证正面照片URL不能超过500个字符'),
            'id_card2_image.url' => __('身份证反面照片必须是有效的URL'),
            'id_card2_image.max' => __('身份证反面照片URL不能超过500个字符'),
            'alipay_qr_image.url' => __('支付宝收款码必须是有效的URL'),
            'alipay_qr_image.max' => __('支付宝收款码URL不能超过500个字符'),
            'wechat_qr_image.url' => __('微信收款码必须是有效的URL'),
            'wechat_qr_image.max' => __('微信收款码URL不能超过500个字符'),
            'bank_card_no.length' => __('银行卡号长度不正确'),
            'bank_card_no.regex' => __('银行卡号格式不正确'),
            'bank_name.max' => __('开户行名称不能超过100个字符'),
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

    /**
     * 自定义银行卡号验证规则
     */
    protected function checkBankCard($value, $rule, $data = [])
    {
        // 银行卡号通常为16-19位数字
        $pattern = '/^\d{16,19}$/';
        return preg_match($pattern, $value) === 1;
    }
}