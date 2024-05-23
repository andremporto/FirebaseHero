//
//  APIView.swift
//  FirebaseHero
//
//  Created by André Porto on 23/05/24.
//

import SwiftUI

struct APIView: View {
    @State private var apiData: String = ""
    
    var body: some View {
        VStack {
            Text(apiData)
            Button("Obter dados da API") {
                fetchData()
            }
        }
        .padding()
        .navigationTitle("Exemplo de API")
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=pt") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let responseData = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    apiData = responseData
                }
            }
        }.resume()
    }
}

#Preview {
    APIView()
}
