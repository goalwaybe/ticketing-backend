<?php

namespace app\admin\controller\ticketuser;

use app\common\controller\Backend;

/**
 * 用户详细资料表（含实名与收款信息）
 */
class UserProfile extends Backend
{
    /**
     * UserProfile模型对象
     * @var object
     * @phpstan-var \app\admin\model\ticketuser\UserProfile
     */
    protected object $model;

    protected string|array $defaultSortField = 'real_name,desc';

    protected string|array $quickSearchField = ['real_name', 'account_name', 'id_card_no', 'user_id'];

    public function initialize(): void
    {
        parent::initialize();
        $this->model = new \app\admin\model\ticketuser\UserProfile();
    }


    /**
     * 若需重写查看、编辑、删除等方法，请复制 @see \app\admin\library\traits\Backend 中对应的方法至此进行重写
     */
}