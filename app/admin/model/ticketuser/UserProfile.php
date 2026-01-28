<?php

namespace app\admin\model\ticketuser;

use think\Model;

/**
 * UserProfile
 */
class UserProfile extends Model
{
    // 表主键
    protected $pk = 'user_id';

    // 表名
    protected $name = 'user_profile';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    /**
     * 关联用户主表
     */
    public function user()
    {
        return $this->belongsTo('TicketUser', 'user_id', 'id');
    }

}