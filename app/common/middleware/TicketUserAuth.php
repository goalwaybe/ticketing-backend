<?php

namespace app\common\middleware;

use Closure;
use think\Request;
use think\Response;
use app\common\facade\Token;
use app\admin\model\ticketuser\TicketUser as TicketUserModel;


class TicketUserAuth
{
    /**
     * 处理请求
     */
    public function handle(Request $request, Closure $next)
    {
        // 获取当前控制器和操作
        $controller = $request->controller();
        $action = $request->action();
        $fullRoute = 'api/' . strtolower($controller) . '/' . $action;

        // 动态获取控制器实例，检查是否为不需要认证的路由
        try {
            $controllerClass = '\\app\\api\\controller\\' . $controller;
            if (class_exists($controllerClass)) {
                $controllerInstance = new $controllerClass();

                // 检查控制器是否有 noNeedAuth 属性
                if (property_exists($controllerInstance, 'noNeedAuth')) {
                    $noNeedAuth = $controllerInstance->noNeedAuth;

                    // 检查当前路由是否在不需要认证的列表中
                    if (is_array($noNeedAuth) && in_array($fullRoute, $noNeedAuth)) {
                        return $next($request);
                    }
                }
            }
        } catch (\Exception $e) {
            // 如果无法实例化控制器，继续执行认证
        }

        // 获取Token
        $token = $this->getTokenFromRequest($request);
        if (!$token) {
            return $this->unauthorized('Token is required');
        }

        // 验证Token
        $tokenInfo = Token::get($token);
        if (!$tokenInfo) {
            return $this->unauthorized('Invalid token or token expired');
        }

        $userId = $tokenInfo['user_id'];

        // 验证用户是否存在且状态正常
        $user = TicketUserModel::where('id', $userId)
            ->where('deleted_at', null)
            ->find();

        if (!$user) {
            return $this->unauthorized('User does not exist');
        }

        if ($user->status == 0) {
            return $this->unauthorized('Your account is under review, please wait');
        } elseif ($user->status == 2) {
            return $this->unauthorized('Your account has been rejected, please contact customer service');
        }

        // 将用户信息存储到请求中
        $request->ticketUser = $user;
        $request->ticketUserId = $userId;

        return $next($request);
    }

    /**
     * 从请求中获取Token
     */
    private function getTokenFromRequest(Request $request): ?string
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

    /**
     * 返回未授权响应
     */
    private function unauthorized(string $message): Response
    {
        $result = [
            'code' => 401,
            'msg' => $message,
            'time' => time(),
            'data' => null,
        ];

        return Response::create($result, 'json', 401)
            ->header([
                'Access-Control-Allow-Origin' => '*',
                'Access-Control-Allow-Headers' => 'Authorization, Content-Type, X-Requested-With',
                'Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE',
            ]);
    }
}