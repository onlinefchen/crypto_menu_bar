import Foundation
import Combine

@MainActor
class AppState: ObservableObject {
    @Published var symbols: [String] = []
    @Published var prices: [String: CoinData] = [:]
    @Published var lastUpdated: Date?
    @Published var apiKey: String = ""
    @Published var selectedSymbol: String = ""
    
    private let service = CryptoService()
    private var timer: Timer?
    private let defaults = UserDefaults.standard
    private let symbolsKey = "saved_symbols"
    private let apiKeyKey = "cmc_api_key"
    private let selectedSymbolKey = "selected_symbol"
    
    init() {
        loadSettings()
        startFetching()
    }
    
    private func loadSettings() {
        if let saved = defaults.stringArray(forKey: symbolsKey) {
            symbols = saved
        } else {
            // Defaults requested by user
            symbols = ["BTCUSDT", "BNBUSDT", "ETHUSDT", "HYPEUSDT", "ASTERUSDT", "OKBUSDT"]
        }
        
        if let savedKey = defaults.string(forKey: apiKeyKey) {
            apiKey = savedKey
        }
        
        if let savedSelected = defaults.string(forKey: selectedSymbolKey), symbols.contains(savedSelected) {
            selectedSymbol = savedSelected
        } else {
            selectedSymbol = symbols.first ?? ""
        }
    }
    
    func saveApiKey(_ key: String) {
        apiKey = key
        defaults.set(key, forKey: apiKeyKey)
        Task {
            await fetchPrices()
        }
    }
    
    func selectSymbol(_ symbol: String) {
        selectedSymbol = symbol
        defaults.set(symbol, forKey: selectedSymbolKey)
    }
    
    func saveSymbols() {
        defaults.set(symbols, forKey: symbolsKey)
        if !symbols.contains(selectedSymbol) {
            selectedSymbol = symbols.first ?? ""
        }
        Task {
            await fetchPrices()
        }
    }
    
    func getAlignedLabel(for symbol: String) -> String {
        let maxLen = symbols.map { $0.count }.max() ?? 0
        let padded = symbol.padding(toLength: maxLen, withPad: " ", startingAt: 0)
        let price = formattedPrice(for: symbol)
        return "\(padded) : \(price)"
    }
    
    func addSymbol(_ symbol: String) {
        let s = symbol.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !s.isEmpty, !symbols.contains(s) else { return }
        symbols.append(s)
        saveSymbols()
    }
    
    func removeSymbol(_ symbol: String) {
        symbols.removeAll { $0 == symbol }
        saveSymbols()
    }
    
    func startFetching() {
        Task {
            await fetchPrices()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                await self?.fetchPrices()
            }
        }
    }
    
    func fetchPrices() async {
        guard !apiKey.isEmpty else {
            print("No API Key provided")
            return
        }
        
        do {
            let newPrices = try await service.fetchPrices(for: symbols, apiKey: apiKey)
            self.prices = newPrices
            self.lastUpdated = Date()
        } catch {
            print("Error fetching prices: \(error)")
        }
    }
    
    func formattedPrice(for symbol: String) -> String {
        guard let data = prices[symbol] else { return "..." }
        
        let price = data.price
        let change = data.percentChange24h
        
        let priceStr: String
        if price < 1.0 {
            priceStr = String(format: "%.4f", price)
        } else if price < 10.0 {
            priceStr = String(format: "%.3f", price)
        } else {
            priceStr = String(format: "%.2f", price)
        }
        
        let changeStr = String(format: "%+.2f%%", change)
        return "\(priceStr) (\(changeStr))"
    }
}
