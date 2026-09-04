# 🎨 拼豆Studio · Bead Studio

> **把灵感一颗一颗烫进珠子里。** 专业的在线拼豆图纸设计工具 —— 从像素到实物,一站式创作。

[![CI](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/ci.yml/badge.svg)](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/ci.yml)
[![Frontend Container](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/ghcr.yml/badge.svg)](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/ghcr.yml)
[![Backend Container](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/backend-ghcr.yml/badge.svg)](https://github.com/Petal1017/Pindou_with_docker_compose/actions/workflows/backend-ghcr.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![React](https://img.shields.io/badge/React-18-61DAFB?logo=react)](https://react.dev)
[![Vite](https://img.shields.io/badge/Vite-6-646CFF?logo=vite)](https://vitejs.dev)
[![Supabase](https://img.shields.io/badge/Supabase-BaaS-3ECF8E?logo=supabase&logoColor=white)](https://supabase.com)
[![i18n](https://img.shields.io/badge/i18n-4%20Languages-4A9B8E)](https://www.i18next.com)

**六个品牌色卡 · 千余种配色 · 四种语言 · 十八篇教程 · 云端账号体系**

拼豆Studio 是一款开箱即用的拼豆图纸在线设计工具:自由绘制、图片智能转图纸、专业图纸导出、云端模板库与账号体系一应俱全。无论是第一次拿起 Pegboard 的新手,还是追求精致作品的进阶玩家,都能在这里找到属于自己的创作节奏。

本分支提供完全本地化的 Docker 部署：前端和自托管 Supabase 后端分别发布到 GHCR，通过一个 Compose 文件启动，不依赖作者的云服务器。

---

## ✨ 亮点速览

| | 功能亮点与应用价值 |
|---|---|
| 🖼️ | **图片一键转图纸** — 上传照片秒变拼豆图纸,K-means++ 取色 + CIEDE2000 精准匹配 |
| 📄 | **专业图纸导出** — 品牌色号标注 + 颜色清单分组,直接对照贴珠 |
| 🎨 | **六大品牌色卡(千余种颜色)** — Perler / Hama / Artkal / COCO / MARD 等随心切换,支持品牌间颜色重映射 |
| ☁️ | **云端账号体系** — 邮箱验证码 / 自定义账号(用户名+安全密钥)两种注册,头像裁剪上传、作品跨设备同步 |
| 🌐 | **4 种语言** — 自动检测浏览器语言,`?lang=` 直达,UI/教程/导出件全量覆盖 |
| 📖 | **18 篇图文教程** — 从入门到进阶,连"翻车急救手册"都有 |
| 📱 | **移动端优先** — 双指捏合缩放、单指惯性平移,手机平板一样顺手 |

---

## 🖊️ 核心功能

### 画布绘制
- **四种工具** — 铅笔 / 橡皮 / 填色桶 / 抓手,拖拽连续绘制零延迟
- **灵活尺寸** — 方形 29–170、矩形预设、自定义 9–200 任意边长
- **平移 / 缩放** — PC 滚轮缩放 + 拖拽平移;移动端双指捏合 + 单指惯性平移
- **撤销 / 重做** — 50 步操作历史,笔画粒度入栈
- **双层 Canvas 渲染机制** — 提交层 + 覆盖层分离,拖拽绘制绕过 React 状态直达画布

### 🖼️ 图片转图纸(颜色科学级)
- **K-means++ 取色** — Lab 色彩空间聚类,7×7 px/格源采样,最大 3000px 输入
- **CIEDE2000 匹配** — 感知均匀色差,蓝/紫色系尤其准确
- **双抖动** — Floyd-Steinberg 蛇形 / Bayer 4×4 有序(作用于 L 通道)
- **ICM 精炼** — 小图额外迭代优化颜色映射
- **零拷贝传输** — Web Worker + Transferable ArrayBuffer,不阻塞主线程

### 🎨 六大品牌色卡
| 品牌 | 色号范围 | 颜色数 | 特点 |
|------|---------|--------|------|
| COCO | A–Z 色系编号 | 291 | 2.6mm 迷你珠,A–Z 分组 |
| MARD | 9 大官方色系 | 221 | 5mm,标准系列 |
| MARD 291 | 标准 221 + 扩展 | 291 | 5mm,系列更全 |
| Perler | P01 – P80 | 80 | 颜色最全,入门首选 |
| Hama | H01 – H56 | 56 | 北欧柔和风格 |
| Artkal | C01 – C100 | 100 | 金属色 / 荧光色丰富 |

模板颜色可在各品牌色卡间按 CIEDE2000 近邻重映射;图库/导出按所选品牌配色。

### 📄 图纸导出(带确认流程)
- **快速三件套** — PNG 位图 / SVG 矢量 / 文本色号索引
- **专业两风格** — 专业图纸(平色方块 + 品牌色号标注,制作参考)/ 展示图纸(拟真立体珠子,分享展示)
- **导出确认框** — 空画布拦截提示;有内容时展示完整设置(格式/说明/风格)后确认
- **成品级信息** — 行列坐标、颜色清单(主色/辅色/点缀色/微量色四档分组)、总珠数统计,3 倍超采样高清渲染

### ☁️ 账号体系(真实云端)
- **两种注册方式** — 邮箱验证码(注册/登录/找回全程验证码,国内网络无需外链);自定义账号(用户名 + 密码 + 可选安全密钥找回)
- **作品跨设备同步** — 登录后作品同步至云端(Supabase),未登录时存本地浏览器;登录时自动把本地作品一并迁入云端
- **个人资料** — 头像上传 + 圆形裁剪(自研裁剪器,拖动/滚轮/双指缩放)、昵称、旧密码验证改密
- **管理员后台** — 模板库 CRUD + JSON 导入 + 统计概览、用户仪表盘(注册统计/搜索分页/注册方式/最近登录,只读合规)

### 📚 图库 · 教程 · 国际化
- **云端模板库** — 内置模板(种子)+ 管理员上传模板全设备统一,公开只读、管理员写入(RLS);模板卡片显示尺寸/难度/品牌色卡/下载量
- **18 篇图文教程** × 4 语言 — 入门指南、熨烫全解、防变形、配色设计、进阶技巧、作品保护
- **i18n 全覆盖** — 浏览器语言自动检测,手动选择持久化,`?lang=en` URL 直达语言页

---

## 🚀 快速开始

### Docker 一键部署（推荐）

环境要求：Docker Engine 24+ 和 Docker Compose v2。后端使用 Docker-in-Docker 封装完整 Supabase 服务栈，因此宿主机必须允许 `privileged` 容器；不支持该能力的平台不能使用此后端镜像。

```bash
git clone https://github.com/Petal1017/Pindou_with_docker_compose.git
cd Pindou_with_docker_compose
cp .env.example .env
docker compose -f docker-compose-example.yml up -d
docker compose -f docker-compose-example.yml ps
```

Windows PowerShell 使用：

```powershell
Copy-Item .env.example .env
docker compose -f docker-compose-example.yml up -d
docker compose -f docker-compose-example.yml ps
```

首次启动后端会继续拉取 PostgreSQL、Auth、REST、Realtime、Storage 和 Edge Runtime 等 Supabase 官方镜像，并执行仓库内迁移，耗时取决于网络和磁盘性能。等待 `backend` 与 `app` 都显示 `healthy` 后访问：

- 应用：http://localhost:17600
- Supabase API：http://localhost:55321
- 本地验证码邮件：http://127.0.0.1:54324（仅回环地址）

默认部署使用轻量服务集，关闭 Studio、Postgres Meta、图片代理、日志分析和连接池辅助服务，保留登录注册、REST/RPC、Realtime、头像存储、Edge Function 及验证码邮件收件箱。数据库和内部镜像保存在 `supabase-docker` volume；普通 `down` 不删除数据，`down -v` 会永久清空本地账号、作品和数据库。

```bash
# 查看日志
docker compose -f docker-compose-example.yml logs -f backend

# 更新两个 GHCR 镜像
docker compose -f docker-compose-example.yml pull
docker compose -f docker-compose-example.yml up -d --force-recreate

# 停止但保留数据
docker compose -f docker-compose-example.yml down
```

镜像地址：

```text
ghcr.io/petal1017/pindou_with_docker_compose:latest
ghcr.io/petal1017/pindou_with_docker_compose-backend:latest
```

### 2C2G 服务器说明

2 核 2 GB 是这套自托管 Supabase 的最低尝试配置，不是宽裕配置。建议配置至少 2 GB swap，预留足够磁盘空间，并避免同机运行其他高内存服务。部署后使用 `docker stats` 和 `docker system df` 观察资源；若内存长期接近 1.7 GB、频繁使用 swap 或发生 OOM，应升级到 4 GB，或改用托管/标准自托管 Supabase。

对公网部署时，必须通过 HTTPS 反向代理同时暴露应用和 Supabase API，并将 `.env` 中的 `SUPABASE_URL` 改为浏览器可访问的公网 HTTPS 地址。不要将 PostgreSQL 或内部 Docker daemon 端口暴露到公网。

### 源码开发

环境要求：Node.js 22、npm 和已启动的 Docker Engine。

### 安装与开发

```bash
git clone https://github.com/Petal1017/Pindou_with_docker_compose.git
cd Pindou_with_docker_compose
npm ci
npm run dev:local
```

`dev:local` 会启动本地 Supabase、生成 `.env.local`，再启动 Vite。开发服务器位于 **http://localhost:5280**。

### 常用命令

```bash
npm run dev            # 开发服务器(热更新)
npm run dev:local      # 启动本地 Supabase 后再运行开发服务器
npm run backend:start  # 仅启动本地 Supabase
npm run backend:stop   # 停止本地 Supabase
npm run backend:reset  # 清空数据库并重新执行迁移和 seed
npm run build          # 生产构建(含子页面静态 HTML)
npm run preview        # 本地预览构建产物
npm run test           # 测试(watch 模式)
npm run test:run       # 测试(单次,CI 模式)
npm run check-i18n     # 验证 4 个语言文件键名一致性
```
---

## 🏗️ 技术栈

| 层 | 技术 |
|----|------|
| 框架 | React 18 + Vite 6 + React Router 7(路径路由) |
| 样式 | Tailwind CSS v4 + 手作暖调设计令牌(CSS 变量) |
| 云端 | Supabase(PostgreSQL + Auth + Storage + 邮件 OTP / 自定义账号) |
| 国际化 | react-i18next,4 语言全量覆盖(UI + 教程 + 导出件) |
| 颜色科学 | CIEDE2000(Lab 空间)+ K-means++(Web Worker) |
| 状态管理 | React `useState` / `useReducer`(无全局 store) |
| 测试 | Vitest + @testing-library/react,75 用例 |
| 部署 | Docker Compose + GHCR 多架构镜像（linux/amd64、linux/arm64） |

---

## 🔬 图片量化流程

```
用户上传图片
    ↓
useImageQuantizer.js(Transferable ArrayBuffer 零拷贝,缩放 7×7 px/格)
    ↓
imageQuantizer.worker.js(Web Worker,不阻塞 UI)
  1. K-means++ 在 Lab 空间选取调色板
  2. CIEDE2000 近邻色匹配
  3. 边缘感知区域采样(高方差格子双均值分析)
  4. Floyd-Steinberg 蛇形 / Bayer 4×4 抖动(L 通道)
  5. ICM 空间精炼(outW ≤ 120)
    ↓
handleQuantizerApply:品牌 ID('P18')→ resolveToHex() → hex('#F0B08A') → canvasData
```

> **铁律**:`canvasData` 只存储 hex 字符串,不存储品牌 ID(`ctx.fillStyle = 'P18'` 会渲染黑块)。

---

## 🧪 测试

```bash
npm run test:run
```

当前 **75 个用例 / 7 个文件**,覆盖:

| 文件 | 覆盖 |
|------|------|
| `colorDiff.test.js` | CIEDE2000(含 CIE 官方 10 组参考值)、rgbToLab、findClosestColorCIEDE2000 |
| `colorUtils.test.js` | resolveToHex 边界、hexToRgb、rgbToHex、getTextColor |
| `historyUtils.test.js` | pushHistory 上限截断、undo/redo 往返一致 |
| `useCanvasPainter.test.js` | 双层 Canvas 绘制、attach 时重绘、overlay 增删 |
| `templates.test.js` | 模板 JSON 校验 12 例(颜色归一化/矩形/错误分支) |
| `Canvas.test.jsx` | 组件级:网格渲染、点击填色、pinch 不误填色回归 |
| `App.test.jsx` | App 冒烟测试:完整组件树渲染(MemoryRouter + HelmetProvider,canvas/matchMedia mock)——捕捉"漏 import → ReferenceError"的生产白屏 |

---

## 🗂 数据存储

**本地(localStorage)**:
| 键 | 内容 |
|-----|------|
| `saved-works` | 未登录时本地作品数组(画布数据/尺寸/调色板/时间),约 5MB 上限、4MB 预警;登录后作品迁往云端并清空该键 |
| `bead_studio_settings` | `{ language }` 语言偏好 |
| `gallery-favorites` | 收藏模板 ID |
| `tutorial-progress` | 已读教程 ID |
| `custom-templates` / `custom-categories` | 本地模式自定义模板/分类(云端未配置时的回退) |

**Supabase 后端（Docker 容器通过运行时 `SUPABASE_URL` + `SUPABASE_ANON_KEY` 注入）**:
| 表 | 内容 |
|----|------|
| `works` | 登录用户的云端作品(`user_id`/`saved_at`/`name` 唯一),RLS 本人可读写 |
| `templates` / `categories` | 云端模板库与分类,匿名公开只读、管理员写入(RLS),`templates` 含 `source`/`palette_id`/`download_count` |
| `profiles` | 昵称、头像、`role`(admin)、自定义账号 `security_key_hash`;`avatars` 存储桶存头像 |
| `download_count`(RPC) | 匿名可调用的模板下载量递增函数 |

Docker 部署的数据位于命名卷 `supabase-docker`。备份、迁移或删除 Compose 文件之前，请先制定 PostgreSQL 和 Storage 数据备份方案；不要把容器本身当作数据备份。

---

## 📦 容器发布

推送到 `main` 后，GitHub Actions 会分别构建并发布前端与后端镜像。推送 `v*` tag 时会额外生成对应版本标签；两个工作流均发布 `linux/amd64` 和 `linux/arm64`。

- `.github/workflows/ghcr.yml`：前端多阶段构建，最终镜像只包含 Nginx 和静态资源。
- `.github/workflows/backend-ghcr.yml`：打包 Supabase CLI、数据库迁移、seed 和 Edge Function。

前端配置在容器启动时写入 `/runtime-config.js`，因此切换 Supabase 地址不需要重新构建前端镜像。完整的本地部署和管理员创建说明见 [LOCAL_SETUP.md](LOCAL_SETUP.md)。

---

## 🤝 贡献指南

1. Fork 本仓库
2. 创建功能分支:`git checkout -b feat/your-feature`
3. 提交前验证:
   ```bash
   npm run test:run && npm run check-i18n && npm run build
   ```
4. Push 并发起 Pull Request

新增 UI 文本请同步更新 `src/i18n/locales/` 下全部四个语言文件(zh-CN 为基准,`check-i18n` 校验键集一致)。新增教程内容请同时维护四语言数据文件(`src/data/tutorials.{zh,en,ja,ko}.js`)。

---

## 📄 License

[MIT](LICENSE) © 2026 Aswellle

---

*从第一颗珠子到第一百颗,愿你每一次拼贴都落子无悔。*
