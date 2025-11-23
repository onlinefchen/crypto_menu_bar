import SwiftUI

struct SettingsView: View {
    @ObservedObject var appState: AppState
    @State private var newSymbol: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Manage Symbols")
                .font(.headline)
            
            VStack(alignment: .leading) {
                Text("CoinMarketCap API Key")
                    .font(.caption)
                SecureField("Enter API Key", text: Binding(
                    get: { appState.apiKey },
                    set: { appState.saveApiKey($0) }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Link("Get Free API Key", destination: URL(string: "https://coinmarketcap.com/api/")!)
                    .font(.caption2)
            }
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                TextField("Symbol (e.g. BTCUSDT)", text: $newSymbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        addSymbol()
                    }
                
                Button(action: addSymbol) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(newSymbol.isEmpty)
            }
            .padding(.horizontal)
            
            List {
                ForEach(appState.symbols, id: \.self) { symbol in
                    HStack {
                        Text(symbol)
                        Spacer()
                        if appState.prices[symbol] != nil {
                            Text(appState.formattedPrice(for: symbol))
                                .foregroundColor(.secondary)
                        }
                        
                        Button(action: {
                            appState.removeSymbol(symbol)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain)
                        .padding(.leading, 8)
                    }
                }
                .onDelete(perform: delete)
            }
            .frame(minHeight: 200)
            
            Text("First symbol is shown in menu bar")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 300, height: 400)
    }
    
    private func addSymbol() {
        guard !newSymbol.isEmpty else { return }
        appState.addSymbol(newSymbol)
        newSymbol = ""
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let symbol = appState.symbols[index]
            appState.removeSymbol(symbol)
        }
    }
}
