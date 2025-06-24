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
    
    func getData() async {
        do {
            guard let url = URL(string: "https://picsum.photos/v2/list") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let imageInfos = try JSONDecoder().decode([ImageInfo].self, from: data)
                print("\"\(imageInfos)\"), randam_image_api_app.Picsum(id: \"\(imageInfos)\", author: \"\(imageInfos)\", width: \(imageInfos), height: \(imageInfos), url:")
                print("\"\(imageInfos)\", download_url:")
    
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
