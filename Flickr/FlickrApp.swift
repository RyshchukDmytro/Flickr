//
//  FlickrApp.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

@main
struct FlickrApp: App {
    var body: some Scene {
        WindowGroup {
            let networkingManager = NetworkManager()
            let photosListViewModel = PhotosListViewModel(networkManager: networkingManager)
            
            PhotosListView(viewModel: photosListViewModel)
        }
    }
}
