//
//  DetailVie.swift
//  api-app
//
//  Created by miyamotokenshin on R 7/06/25.
//

import SwiftUI

struct DetailView: View {
    let imageInfo: ContentView.ImageInfo
    var body: some View {
        AsyncImage(url: URL(string: imageInfo.download_url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 400)
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    DetailView(imageInfo: ContentView.ImageInfo(
        id: "",
        author: "",
        width: 0,
        height: 0,
        url: "",
        download_url: ""
    ))
}
