//
//  ImageDetailsView.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

struct ImageDetailsView: View {
    @ObservedObject var viewModel: ImageDetailsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                AsyncImage(url: URL(string: viewModel.imageInfo.media.imageUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text(viewModel.imageInfo.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .dynamicTypeSize(.xSmall ... .xxLarge)
                
                Text(viewModel.imageInfo.tags)
                    .font(.title3)
                    .dynamicTypeSize(.xSmall ... .xxLarge)
                
                Text(viewModel.extractTitle(from: .description))
                    .font(.callout)
                    .dynamicTypeSize(.xSmall ... .xxLarge)
                
                Text(viewModel.extractTitle(from: .author))
                    .font(.callout)
                    .dynamicTypeSize(.xSmall ... .xxLarge)
                
                Spacer()
            }
        }
        .navigationTitle("Image Details")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

