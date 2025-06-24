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
    
    struct ImageInfo: Codable {
        let id: String
        let author: String
        let width: Int
        let height: Int
        let url: String
        let download_url: String
    }
    
    // https://note.com/dngri/n/n98ea0016049c
    func getData() async {
        do {
            guard let url = URL(string: "https://picsum.photos/v2/list") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            // dataをString型に変換する
            // https://qiita.com/SNQ-2001/items/41efeb0a9fb4fa898177
            // let dataString = String(data: data, encoding: .utf8)
            let imageInfos = try JSONDecoder().decode([ImageInfo].self, from: data)
            for info in imageInfos {
                print("\"\(info.download_url)\"), randam_image_api_app.Picsum(id: \"\(info.id)\", author: \"\(info.author)\", width: \(info.width), height: \(info.height), url:")
                print("\"\(info.url)\", download_url:")
            }
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
