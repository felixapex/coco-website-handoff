# Coco 完整网站交接包 v3（干净版）

## 本版验证结果

- 169 条电脑版路由、169 条手机版路由、2596 张图片，连续 5 轮全部通过。
- 3234 个交付载荷文件全部进入 `SHA256SUMS.txt`，完整性验证通过。
- 168 个正式 HTML 的外部运行资源为 0。
- 原 Coco、BigCommerce、Zendesk、关联品牌和外部目录跳转为 0。
- 社交、地图、政府、物流、招聘、预约等明确站外服务链接允许保留，但不参与网站加载。
- 抓取、处理、生成、清理和验收源码已放入交接包 `tools/`；不包含平台后端和 `node_modules`。

## 下载

下载本目录全部 26 个分卷，从：

`Coco-Website-Handoff-2026-11-21-v3.7z.001`

到：

`Coco-Website-Handoff-2026-11-21-v3.7z.026`

所有分卷必须放在同一目录，不能改名。

## 校验

在 PowerShell 中执行：

```powershell
powershell -ExecutionPolicy Bypass -File .\verify-parts.ps1
```

脚本会检查全部 26 个分卷，并校验重组后的 7z 数据。整包 SHA256：

`9aed0185f7ec4421444a45b65ec32376292e3e4c23c032ee40f21c398cac5279`

## 解压和运行

安装 7-Zip 后，右键第一个分卷 `Coco-Website-Handoff-2026-11-21-v3.7z.001`，选择“7-Zip → 解压到当前文件夹”。

解压后：

1. 双击 `start-site.cmd`。
2. 打开 `http://127.0.0.1:4173/`。
3. 如需复验，双击 `verify-package.cmd`。

`127.0.0.1` 只供接收方本机预览。要让公网用户访问，仍需部署到服务器或静态托管并绑定域名。

## 校验文件

- `PARTS-SHA256SUMS.txt`：26 个分卷的 SHA256。
- `ARCHIVE-SHA256.txt`：重组后 7z 数据的 SHA256。
- `PACKAGE-FILES-SHA256SUMS.txt`：解压后 3234 个载荷文件的 SHA256。
