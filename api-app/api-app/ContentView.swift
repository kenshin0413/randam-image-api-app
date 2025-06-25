//
//  ContentView.swift
//  api-app
//
//  Created by miyamotokenshin on R 7/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var imageInfos: [ImageInfo] = []
    var body: some View {
        NavigationStack {
            List(imageInfos, id: \.id) { info in
                NavigationLink(destination: DetailView(imageInfo: info)) {
                    LabeledContent {
                        Text(info.id)
                    } label: {
                        Text(info.author)
                    }
                }
            }
            .task {
                await getData()
            }
        }
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
            let decodedData = try JSONDecoder().decode([ImageInfo].self, from: data)
            imageInfos = decodedData
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
