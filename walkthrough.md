# Crypto Menu Bar Walkthrough

I have built a native macOS Menu Bar application using Swift and SwiftUI.

## Features
- **Menu Bar Ticker**: Shows the price of your top priority coin (e.g., BTC) directly in the menu bar.
- **Dropdown Details**: Click to see a list of all configured coins.
- **Settings Window**: Add and remove coins dynamically.
- **Persistence**: Remembers your coin list across restarts.
- **Real-time Updates**: Polls Binance API every 10 seconds.

## Implementation Details
- **Language**: Swift 5.9
- **UI Framework**: SwiftUI (using `MenuBarExtra` API available in macOS 13+)
- **Networking**: `URLSession` with `async/await`.
- **Data Source**: Binance Public API (`/api/v3/ticker/price`).

## Verification
- **Build**: The project builds successfully using `swift build`.
- **Packaging**: `build_app.sh` creates a valid `CryptoMenuBar.app` bundle with `LSUIElement=true` to hide it from the Dock.
- **Logic**:
    - `CryptoService` fetches all tickers to avoid errors with invalid symbols.
    - `AppState` filters and formats the prices.
    - `SettingsView` allows management of the symbol list.

## How to Use
1. Run `open CryptoMenuBar.app`.
2. Look for the Bitcoin icon (or price) in your menu bar.
3. Click it to see other prices or open Settings.
