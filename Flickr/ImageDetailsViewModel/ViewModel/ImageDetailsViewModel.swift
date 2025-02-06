//
//  ImageDetailsViewModel.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import Foundation

class ImageDetailsViewModel: ObservableObject {
    enum ExtractType {
        case description, author
    }
    
    let imageInfo: ItemModel
    
    init(imageInfo: ItemModel) {
        self.imageInfo = imageInfo
    }
    
    func extractTitle(from type: ExtractType) -> String {
        let pattern: String
        let text: String
        let textIfEmpty: String
        
        switch type {
        case .description:
            pattern = #"title="([^"]+)""#
            text = imageInfo.description
            textIfEmpty =  "No description found"
        case .author:
            pattern = #"\("([^"]+)"\)"#
            text = imageInfo.author
            textIfEmpty = imageInfo.author
        }
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return "Something went wrong" }
        
        let range = NSRange(text.startIndex..<text.endIndex, in: text)
        if let match = regex.firstMatch(in: text, options: [], range: range),
           let titleRange = Range(match.range(at: 1), in: text) {
            return String(text[titleRange])
        }
        
        return textIfEmpty
    }
}
