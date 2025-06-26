//
//  ContentView.swift
//  api-app
//
//  Created by miyamotokenshin on R 7/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var imageInfos: [ImageInfo] = []
    // falseを基本として持たせないと最初からアラートが表示されてしまう
    @State private var showErrorAlert = false
    // エラーが起きてる原因によって文章が変わるから//@Stateが必要
    @State private var errorMessage = ""
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
            .alert("エラー", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
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
            errorMessage = error.localizedDescription
            showErrorAlert = true
            
        }
    }
}

#Preview {
    ContentView()
}
