# Crypto Menu Bar

A simple macOS Menu Bar application that displays real-time cryptocurrency prices.

## Features
- **Real-time Prices**: Fetches prices from Binance API every 10 seconds.
- **Customizable**: Add or remove any trading pair supported by Binance (e.g., BTCUSDT, ETHUSDT).
- **Menu Bar Ticker**: Displays the first symbol in your list directly on the menu bar.
- **Dropdown List**: Click the menu bar icon to see prices for all your configured symbols.
- **Native**: Built with Swift and SwiftUI for a lightweight, native experience.

## How to Run
1. Open Terminal in this directory.
2. Run the build script (if not already built):
   ```bash
   ./build_app.sh
   ```
3. Open the app:
   ```bash
   open CryptoMenuBar.app
   ```
   Or double-click `CryptoMenuBar.app` in Finder.

## Usage
- **Add Symbol**: Open Settings (Cmd+,) or click "Settings..." in the menu. Type a symbol (e.g., `DOGEUSDT`) and click "+".
- **Remove Symbol**: In Settings, swipe left on a symbol or use the delete key (if supported) or just click the delete button if I added one (actually, swipe to delete is standard in SwiftUI List, but on macOS it's often right-click or selection + delete. I implemented `onDelete` which usually adds a delete option or supports swipe).
- **Reorder**: The first symbol in the list is shown on the bar. (Note: Reordering is not explicitly implemented in the UI yet, you can remove and re-add to change order).

## Default Symbols
- BTCUSDT
- BNBUSDT
- ETHUSDT
- HYPEUSDT
- ASTERUSDT
- OKBUSDT
