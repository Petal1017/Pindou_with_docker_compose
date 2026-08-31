# 完全本地运行

这个仓库包含完整的 Supabase 后端定义，并非只能连接作者的服务器。`supabase/migrations/` 提供数据库表、RLS 权限、Auth 触发器、Storage、RPC、模板种子和后台管理逻辑；`supabase/functions/contact-us/` 是联系消息的 Edge Function。

## 前置条件

- Node.js 22（仓库的 `.nvmrc` 与 `package.json` 均以此为准）
- Docker Desktop，并确保 Docker Engine 已启动

## 启动

```powershell
npm install
npm run dev:local
```

首次启动会下载 Supabase Docker 镜像并执行全部迁移，耗时取决于网络。命令会自动从本机 Supabase 读取 URL 和匿名密钥、写入 `.env.local`，随后在 http://localhost:5280 启动前端。

本地服务地址：

- 应用：http://localhost:5280
- Supabase Studio：http://127.0.0.1:54323
- 本地邮件收件箱：http://127.0.0.1:54324
- API：http://127.0.0.1:55321

邮箱验证码不会发送到公网邮箱。注册或登录后，在本地邮件收件箱中打开邮件并查看验证码。

## 常用命令

```powershell
npm run backend:status # 查看本地服务和密钥
npm run backend:reset  # 清空本地数据并重新执行迁移/种子
npm run backend:stop   # 停止本地 Supabase 容器
npm run backend:env    # 仅重新生成前端 .env.local
```

## 创建管理员

1. 在应用内注册一个账号。
2. 打开 Supabase Studio 的 SQL Editor。
3. 使用该账号邮箱执行：

```sql
update public.profiles
set role = 'admin'
where id = (select id from auth.users where email = '你的邮箱');
```

然后退出并重新登录，通过 `/admin/login` 进入后台。

## 联系消息功能

`supabase start` 会自动加载 `supabase/functions/contact-us/`。本地未配置 `TURNSTILE_SECRET_KEY` 时，函数按源码约定跳过 Cloudflare 人机验证；生产或局域网公开部署时应配置 Turnstile。

## 数据位置

登录后的账号、作品和模板数据位于本机 Docker volumes；未登录作品仍保存在浏览器 `localStorage`。`backend:stop` 不删除数据，`backend:reset` 会清空并重建数据库。

## 单容器应用镜像

应用镜像只包含构建后的前端与 Nginx，不需要特权权限，也不会在容器中嵌套 Docker。Supabase 是独立后端，开发机可继续使用前文的 `npm run backend:start`，生产环境可连接自托管或托管 Supabase。

本地构建并启动：

```powershell
docker compose up --build -d
docker compose ps
```

应用地址为 http://localhost:5280。容器启动时会根据 `SUPABASE_URL`、`SUPABASE_ANON_KEY` 和 `TURNSTILE_SITE_KEY` 生成运行时配置，因此修改连接目标不需要重新构建镜像。

停止但保留数据：

```powershell
docker compose down
```

使用环境文件：

```powershell
Copy-Item .env.example .env
docker compose up -d
```

`SUPABASE_URL` 是浏览器访问的地址，不能填写 Docker 内部服务名。局域网访问时应填写服务器 LAN 地址，例如 `http://192.168.1.10:55321`；HTTPS 站点必须使用 HTTPS Supabase 地址，否则浏览器会拦截混合内容。

## GHCR 发布

`.github/workflows/ghcr.yml` 会在推送到 `main`、推送 `v*` tag 或手动触发时构建 `linux/amd64` 与 `linux/arm64` 镜像，并推送到：

```text
ghcr.io/<GitHub owner>/<repository>:latest
```

工作流使用仓库自带的 `GITHUB_TOKEN`，无需额外 Docker 密码。仓库设置中需要允许 GitHub Actions 对 Packages 写入；首次发布后可在 GitHub Packages 页面调整镜像可见性。

从 GHCR 部署：

```powershell
docker pull ghcr.io/<GitHub owner>/<repository>:latest
docker run -d --name pindou-studio --restart unless-stopped `
  -p 5280:80 `
  -e SUPABASE_URL=https://your-supabase.example.com `
  -e SUPABASE_ANON_KEY=your-anon-key `
  ghcr.io/<GitHub owner>/<repository>:latest
```

生产服务器只需 `docker-compose.prod.yml` 和 `.env`。设置 `PINDOU_IMAGE`、`SUPABASE_URL`、`SUPABASE_ANON_KEY` 后执行：

```powershell
docker compose -f docker-compose.prod.yml pull
docker compose -f docker-compose.prod.yml up -d
```

生产 Compose 不构建源码，也不包含特权模式、Docker-in-Docker 或数据库数据卷。Supabase 需独立部署，`SUPABASE_URL` 必须是访问页面的浏览器可以访问的地址。
