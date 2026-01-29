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


    /**
     * 查看
     * @throws Throwable
     */
    public function index(): void
    {
        if ($this->request->param('select')) {
            $this->select();
        }

        list($where, $alias, $limit, $order) = $this->queryBuilder();

        // 添加软删除过滤条件：只显示 deleted_at 为 NULL 的记录
        $where[] = ['deleted_at', '=', null];

        $res = $this->model
            ->field($this->indexField)
            ->withJoin($this->withJoinTable, $this->withJoinType)
            ->alias($alias)
            ->where($where)
            ->order($order)
            ->paginate($limit);

        $this->success('', [
            'list'   => $res->items(),
            'total'  => $res->total(),
            'remark' => get_route_remark(),
        ]);
    }
}