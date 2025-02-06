//
//  PhotoModel.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import Foundation

struct MediaModel: Codable, Hashable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "m"
    }
}

struct ItemModel: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let link: String
    let media: MediaModel
    let published: String
    let description: String
    let author: String
    let tags: String
    
    enum CodingKeys: CodingKey {
        case title, link, media, published, description, author, tags
    }
}

struct PhotoModel: Codable {
    let items: [ItemModel]
}
