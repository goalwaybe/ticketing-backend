<?php

namespace app\admin\controller\ticketuser;

use app\common\controller\Backend;

/**
 * 用户主表（登录凭证）
 */
class TicketUser extends Backend
{
    /**
     * TicketUser模型对象
     * @var object
     * @phpstan-var \app\admin\model\ticketuser\TicketUser
     */
    protected object $model;

    protected array|string $preExcludeFields = ['id', 'password_hash'];

    protected string|array $quickSearchField = ['id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\ticketuser\TicketUser();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}