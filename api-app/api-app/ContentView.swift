//
//  ContentView.swift
//  api-app
//
//  Created by miyamotokenshin on R 7/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    await getData()
                }
            }, label: {
                Text("取得")
            })
        }
        .padding()
    }
    // https://note.com/dngri/n/n98ea0016049c
    func getData() async {
        do {
            guard let url = URL(string: "https://picsum.photos/v2/list") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            // dataをString型に変換する
            // https://qiita.com/SNQ-2001/items/41efeb0a9fb4fa898177
            let dataString = String(data: data, encoding: .utf8)
            print(dataString as Any)
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
