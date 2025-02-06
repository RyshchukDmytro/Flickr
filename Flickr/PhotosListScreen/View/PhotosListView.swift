//
//  PhotosListView.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

struct PhotosListView: View {
    @ObservedObject var viewModel: PhotosListViewModel
    @State private var searchText: String = ""
    @State private var selectedImage: ItemModel?
    private let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Group {
                        if viewModel.isLoading && viewModel.allImages.isEmpty {
                            loadingView
                        } else if viewModel.allImages.isEmpty {
                            emptyStateView
                        } else {
                            imagesGrid
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                Task {
                    try await viewModel.getRequest(by: searchText)
                }
            }
            .padding()
            .navigationDestination(item: $selectedImage) { imageInfo in
                let detailsModel = ImageDetailsViewModel(imageInfo: imageInfo)
                ImageDetailsView(viewModel: detailsModel)
            }
        }
    }
    
    private var imagesGrid: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.allImages, id: \.id) { imageInfo in
                AsyncImageView(url: imageInfo.media.imageUrl, viewModel: viewModel)
                    .onTapGesture {
                        selectedImage = imageInfo
                    }
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
            Text("Don't be shy, make a first search")
                .font(.title2)
                .bold()
                .dynamicTypeSize(.xSmall ... .xxLarge)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
