//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import XCTest
@testable import Flickr

final class FlickrTests: XCTestCase {
    
    func testExtractPhotoTitle() {
        let htmlString = #"<p><a href="https://www.flickr.com/people/119791587@N06/">Ellen May Nielsen</a> posted a photo:</p> <p><a href="https://www.flickr.com/photos/119791587@N06/54311048898/" title="6. februar 2025_1444-NEF_DxO_DeepPRIME kopi"><img src="https://live.staticflickr.com/65535/54311048898_4ac9fa529d_m.jpg" width="236" height="240" alt="6. februar 2025_1444-NEF_DxO_DeepPRIME kopi" /></a></p>"#
        
        let itemModel = ItemModel(title: "Test", link: "Test", media: MediaModel(imageUrl: ""), published: "1-1-02", description: htmlString, author: "", tags: "")
        let imageDetailsViewModel = ImageDetailsViewModel(imageInfo: itemModel)
        
        let extractedTitle = imageDetailsViewModel.extractTitle(from: .description)
        
        XCTAssertEqual(extractedTitle, "6. februar 2025_1444-NEF_DxO_DeepPRIME kopi")
    }
    
    func testExtractUsernameFromEmail() {
        let author = #"nobody@flickr.com ("Marco_Lucas")"#
        
        let itemModel = ItemModel(title: "Test", link: "Test", media: MediaModel(imageUrl: ""), published: "1-1-02", description: "", author: author, tags: "")
        let imageDetailsViewModel = ImageDetailsViewModel(imageInfo: itemModel)
        
        let extractedTitle = imageDetailsViewModel.extractTitle(from: .author)
        
        XCTAssertEqual(extractedTitle, "Marco_Lucas")
    }
    
    func testExtractUsername_InvalidFormat() {
        let invalidString = #"nobody@flickr.com Marco_Lucas"#
        
        let itemModel = ItemModel(title: "Test", link: "Test", media: MediaModel(imageUrl: ""), published: "1-1-02", description: "", author: invalidString, tags: "")
        let imageDetailsViewModel = ImageDetailsViewModel(imageInfo: itemModel)
        
        let extractedUsername = imageDetailsViewModel.extractTitle(from: .author)
        
        XCTAssertEqual(extractedUsername, invalidString)
    }
}
