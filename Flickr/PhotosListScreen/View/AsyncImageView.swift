//
//  AsyncImageView.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    @ObservedObject var viewModel: PhotosListViewModel
    @State private var image: Image? = nil
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFit()
            } else {
                Color.gray.opacity(0.6)
                    .frame(width: 100, height: 100)
                    .onAppear {
                        Task {
                            do {
                                image = try await viewModel.getImage(for: url)
                            } catch {
                                image = Image(systemName: "book")
                            }
                        }
                    }
            }
        }
    }
}

