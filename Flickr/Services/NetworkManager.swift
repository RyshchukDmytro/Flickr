//
//  NetworkManager.swift
//  Flickr
//
//  Created by Dmytro Ryshchuk on 2/6/25.
//

import SwiftUI

class NetworkManager {
    func getRequest(by phrase: String) async throws -> PhotoModel {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(phrase)") else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw URLError(.badServerResponse)
            }
            
            let da = try JSONDecoder().decode(PhotoModel.self, from: data)
            return da
        } catch {
            throw error
        }
    }
    
    func getImage(for stringUrl: String) async throws -> Image {
        guard let url = URL(string: stringUrl) else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let image = UIImage(data: data) {
                return Image(uiImage: image)
            }
            
            return Image(systemName: "book.fill")
        } catch {
            throw error
        }
    }
}
