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

}