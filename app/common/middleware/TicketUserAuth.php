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
        // 获取当前请求路径（例如：/api/ticket_user/register）
        $path = $request->pathinfo();
        // 去掉开头的斜杠，并确保路径格式
        $path = trim($path, '/');

        // 如果路径以api开头，则转换为中间件内部使用的格式
        if (strpos($path, 'api/') === 0) {
            $route = $path;
        } else {
            $route = 'api/' . $path;
        }

        // 动态获取控制器实例，检查是否为不需要认证的路由
        try {
            // 从路径中解析出控制器名和方法名（假设路径格式为 api/控制器/方法）
            $routeParts = explode('/', $route);
            if (count($routeParts) >= 3) {
                $controllerName = $routeParts[1]; // 控制器名（例如：ticket_user）
                $actionName = $routeParts[2];     // 方法名（例如：register）

                // 将蛇形命名转换为驼峰命名（用于类名）
                $controllerClass = '\\app\\api\\controller\\' . str_replace(' ', '', ucwords(str_replace('_', ' ', $controllerName)));

                if (class_exists($controllerClass)) {
                    $reflectionClass = new \ReflectionClass($controllerClass);
                    if ($reflectionClass->hasProperty('noNeedAuth')) {
                        $property = $reflectionClass->getProperty('noNeedAuth');
                        $property->setAccessible(true);
                        $noNeedAuth = $property->getValue();

                        if (is_array($noNeedAuth) && in_array($route, $noNeedAuth)) {
                            return $next($request);
                        }
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
        $tokenInfo = Token::get($token, 'ticketUser');
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