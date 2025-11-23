import SwiftUI

@main
struct CryptoMenuBarApp: App {
    @StateObject private var appState = AppState()
    @Environment(\.openWindow) var openWindow
    
    var body: some Scene {
        MenuBarExtra {
            // Menu Items
            ForEach(appState.symbols, id: \.self) { symbol in
                Button {
                    appState.selectSymbol(symbol)
                    // Optional: Copy to clipboard as well?
                    let price = appState.formattedPrice(for: symbol)
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(price, forType: .string)
                } label: {
                    Text(appState.getAlignedLabel(for: symbol))
                        .font(.system(.body, design: .monospaced))
                }
            }
            
            Divider()
            
            Button("Settings...") {
                openWindow(id: "settings")
                NSApp.activate(ignoringOtherApps: true)
            }
            .keyboardShortcut(",", modifiers: .command)
            
            Divider()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
            
        } label: {
            if appState.apiKey.isEmpty {
                Image(systemName: "exclamationmark.triangle")
            } else if !appState.selectedSymbol.isEmpty {
                let shortName = appState.selectedSymbol.replacingOccurrences(of: "USDT", with: "")
                let price = appState.formattedPrice(for: appState.selectedSymbol)
                Text("\(shortName) \(price)")
            } else {
                Image(systemName: "bitcoinsign.circle")
            }
        }
        .menuBarExtraStyle(.menu)
        
        WindowGroup("Settings", id: "settings") {
            SettingsView(appState: appState)
        }
        .windowResizability(.contentSize)
        .defaultSize(width: 300, height: 400)
    }
}
