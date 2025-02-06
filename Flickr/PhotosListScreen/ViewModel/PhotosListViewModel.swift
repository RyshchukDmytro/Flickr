//
//  PhotosListViewModel.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

class PhotosListViewModel: ObservableObject {
    let networkManager: NetworkManager
    @Published private(set) var isLoading = false
    @Published private(set) var allImages: [ItemModel] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getRequest(by phrase: String) async throws {
        isLoading = true
        defer { isLoading = false }
        
        allImages = try await networkManager.getRequest(by: phrase).items
    }
    
    func getImage(for stringUrl: String) async throws -> Image {
        try await networkManager.getImage(for: stringUrl)
    }
}

