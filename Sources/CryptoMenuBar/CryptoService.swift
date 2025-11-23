import Foundation

// CMC Response Structures
struct CMCResponse: Codable {
    let data: [String: CMCQuote]
}

struct CMCQuote: Codable {
    let symbol: String
    let quote: [String: CMCPriceInfo]
}

struct CMCPriceInfo: Codable {
    let price: Double
    let percent_change_24h: Double
}

struct CoinData {
    let price: Double
    let percentChange24h: Double
}

class CryptoService {
    private let baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
    
    func fetchPrices(for symbols: [String], apiKey: String) async throws -> [String: CoinData] {
        // 1. Parse symbols: "BTCUSDT" -> "BTC"
        // We assume the user wants prices in USDT/USD. CMC quotes endpoint takes "symbol" (e.g. BTC,ETH)
        // and "convert" (e.g. USD or USDT).
        
        var symbolMap: [String: String] = [:] // "BTC" -> "BTCUSDT"
        var querySymbols: Set<String> = []
        
        for fullSymbol in symbols {
            // Simple heuristic: if it ends in USDT, strip it. Else use as is.
            let raw = fullSymbol.uppercased()
            let base: String
            if raw.hasSuffix("USDT") {
                base = String(raw.dropLast(4))
            } else {
                base = raw
            }
            
            if !base.isEmpty {
                querySymbols.insert(base)
                symbolMap[base] = fullSymbol
            }
        }
        
        guard !querySymbols.isEmpty else { return [:] }
        
        let symbolsParam = querySymbols.joined(separator: ",")
        
        // Construct URL
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "symbol", value: symbolsParam),
            URLQueryItem(name: "convert", value: "USDT") // Requesting price in USDT
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if httpResponse.statusCode != 200 {
            // Try to decode error message if possible, or just throw
            print("CMC API Error: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(CMCResponse.self, from: data)
        
        var result: [String: CoinData] = [:]
        
        for (key, quoteData) in decoded.data {
            // key is the symbol like "BTC"
            if let info = quoteData.quote["USDT"],
               let fullSymbol = symbolMap[key] {
                result[fullSymbol] = CoinData(price: info.price, percentChange24h: info.percent_change_24h)
            }
        }
        
        return result
    }
}
