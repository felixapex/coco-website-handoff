# Coco 完整网站交接包 v2 下载与还原

## 本版补充内容

- `/blog` 的4个实际外部资源已改为本地文件：favicon、图标精灵、登录抽屉电脑版图片、登录抽屉手机版图片。
- `SHA256SUMS.txt` 覆盖交付包内除清单自身外的全部3266个载荷文件。
- 自带验证程序每轮检查169个电脑版路由、169个手机版路由和全部2596张图片，不再抽查64张。
- 增加抓取、处理、页面生成和自动验收工具源码；不包含平台后端和 `node_modules`。

## 下载

请下载本目录全部31个分卷，文件名从：

`Coco-Website-Handoff-2026-11-20-v2.7z.001`

到：

`Coco-Website-Handoff-2026-11-20-v2.7z.031`

所有分卷必须放在同一个目录，不能改名。

## 校验

在 PowerShell 中执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\verify-parts.ps1
```

脚本会检查31个分卷各自的 SHA256，并计算重组后7z整包的 SHA256。整包正确值为：

`a7449df56603c442b6dd5f32ab41639d821b1b9fca892228700f840ec2b4808c`

## 解压

安装 7-Zip 后，只需要右键第一个分卷：

`Coco-Website-Handoff-2026-11-20-v2.7z.001`

选择“7-Zip -> 解压到当前文件夹”。7-Zip 会自动读取其余30个分卷。

解压后，双击交接包根目录的 `start-site.cmd`，再打开 `http://127.0.0.1:4173/`。

要复验完整交付包，双击 `verify-package.cmd`。该程序会校验全部文件哈希、全部电脑版/手机版路由和全部图片，并且不会改写交付包。

## 校验文件

- `PARTS-SHA256SUMS.txt`：31个分卷各自的 SHA256。
- `ARCHIVE-SHA256.txt`：重组后7z文件的 SHA256。
- `PACKAGE-FILES-SHA256SUMS.txt`：解压后全部3266个载荷文件的 SHA256，清单自身除外。
