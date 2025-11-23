# Crypto Menu Bar / 加密货币菜单栏助手

A simple, native macOS Menu Bar application that displays real-time cryptocurrency prices.
一个简单、原生的 macOS 菜单栏应用程序，用于显示实时加密货币价格。

![Menu Bar Ticker / 菜单栏行情](screenshots/menubar.png)

## Features / 功能特性

- **Real-time Prices**: Fetches prices from CoinMarketCap API every 10 seconds.
  **实时价格**：每 10 秒从 CoinMarketCap API 获取一次价格。

- **Customizable**: Add or remove any trading pair (e.g., BTCUSDT, ETHUSDT).
  **可定制**：添加或删除任何交易对（例如 BTCUSDT、ETHUSDT）。

- **Menu Bar Ticker**: Displays the selected symbol directly on the menu bar.
  **菜单栏行情**：直接在菜单栏上显示选定的币种。

- **Dropdown List**: Click to see prices and 24h change for all configured symbols.
  **下拉列表**：点击查看所有配置币种的价格和 24 小时涨跌幅。

- **Native Experience**: Built with Swift and SwiftUI, featuring a clean, aligned UI with bold fonts.
  **原生体验**：使用 Swift 和 SwiftUI 构建，具有整洁、对齐的 UI 和清晰的粗体字体。

![Dropdown Menu / 下拉菜单](screenshots/dropdown.png)

## Installation / 安装

### Download / 下载

Download the latest release from the [Releases page](https://github.com/onlinefchen/crypto_menu_bar/releases).
从 [Releases 页面](https://github.com/onlinefchen/crypto_menu_bar/releases) 下载最新版本。

### Install / 安装步骤

1. Open the downloaded DMG file.
   打开下载的 DMG 文件。

2. Drag **CryptoMenuBar.app** to the **Applications** folder.
   将 **CryptoMenuBar.app** 拖拽到 **Applications** 文件夹。

3. Launch the app from Applications or Spotlight.
   从应用程序文件夹或 Spotlight 启动应用。

### First Launch / 首次启动

If you see a security warning saying the app is damaged or from an unidentified developer:
如果您看到安全警告，提示应用已损坏或来自未识别的开发者：

**Method 1 / 方法一：**
1. Right-click (or Control-click) the app in Applications folder.
   在应用程序文件夹中右键点击（或按住 Control 点击）应用。

2. Select "Open" from the menu.
   从菜单中选择"打开"。

3. Click "Open" in the dialog that appears.
   在出现的对话框中点击"打开"。

**Method 2 / 方法二：**
Run this command in Terminal:
在终端中运行此命令：
```bash
xattr -cr /Applications/CryptoMenuBar.app
```

> **Note / 注意**: This security warning appears because the app is not code-signed with an Apple Developer certificate. The app is open source and safe to use.
> 
> 此安全警告出现是因为应用未使用 Apple 开发者证书进行代码签名。该应用是开源的，可以安全使用。

### Build from Source / 从源码构建

If you prefer to build from source:
如果您希望从源码构建：

1. Clone this repository.
   克隆此仓库。

2. Run the build script:
   运行构建脚本：
   ```bash
   ./build_app.sh
   ```

3. Open the app:
   打开应用程序：
   ```bash
   open CryptoMenuBar.app
   ```

## Configuration / 配置

1. **API Key**: You need a CoinMarketCap API Key.
   **API 密钥**：您需要一个 CoinMarketCap API 密钥。

2. **Settings**: Click the menu bar icon -> "Settings..." to enter your key and manage coins.
   **设置**：点击菜单栏图标 -> "Settings..." 输入您的密钥并管理币种。

## Default Symbols / 默认币种

- BTCUSDT
- BNBUSDT
- ETHUSDT
- HYPEUSDT
- ASTERUSDT
- OKBUSDT
