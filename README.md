# ticketing-backend 后台管理系统

基于 **ThinkPHP 8** + **BuildAdmin v2.1.3** 的模块化后台管理平台，前端采用 **Vue 3 + TypeScript**，支持 RBAC 权限控制、多模块开发与一键部署。

## ✨ 特性
- 🛠 模块化架构（用户、权限、系统等独立模块）
- 🔒 完善的管理员/会员双角色权限体系
- 🌐 前后端分离，API 返回标准 JSON
- 📦 内置文件上传、操作日志、接口节流
- 🚀 支持 `php think run` 开发 & Nginx 生产部[README.md](../PHP%E9%A1%B9%E7%9B%AE%E6%BA%90%E7%A0%81/newcmt/README.md)署

## 🚦 快速启动
```bash
# 后端（PHP 8.0+）
php think run[README.md](../PHP%E9%A1%B9%E7%9B%AE%E6%BA%90%E7%A0%81/newcmt/README.md)

# 前端（进入 web/ 目录）
pnpm install
pnpm run dev 
pnpm build

然后移动构建文件到 public/assets 下

npm run serve