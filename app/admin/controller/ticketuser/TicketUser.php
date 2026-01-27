<?php

namespace app\admin\controller\ticketuser;

use app\common\controller\Backend;
use Throwable;

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


    /**
     * 删除（软删除）
     * @throws Throwable
     */
    public function del(): void
    {
        $where             = [];
        $dataLimitAdminIds = $this->getDataLimitAdminIds();
        if ($dataLimitAdminIds) {
            $where[] = [$this->dataLimitField, 'in', $dataLimitAdminIds];
        }

        $ids     = $this->request->param('ids/a', []);
        $where[] = [$this->model->getPk(), 'in', $ids];
        $data    = $this->model->where($where)->select();

        $count = 0;
        $this->model->startTrans();
        try {
            foreach ($data as $v) {
                // 临时使用 datetime 格式
                $v->deleted_at = date('Y-m-d H:i:s');
                $count += $v->save() ? 1 : 0;
            }
            $this->model->commit();
        } catch (Throwable $e) {
            $this->model->rollback();
            $this->error($e->getMessage());
        }
        if ($count) {
            $this->success(__('Deleted successfully'));
        } else {
            $this->error(__('No rows were deleted'));
        }
    }
}