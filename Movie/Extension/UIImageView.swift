//
//  UIImageView.swift
//  Movie
//
//  Created by Wai Thura Tun on 08/05/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func setApiImage(url: String) {
        let imageURL = URL(string: url)
        
        guard let imageURL = imageURL else { return }
        
        if let cacheImage = URLCache.shared.cachedResponse(for: .init(url: imageURL)) {
            if let image = UIImage(data: cacheImage.data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
        }
        else {
            URLSession.shared.dataTask(with: .init(url: imageURL)) { data, response, error in
                if let _ = error {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else { return }
                
                guard let data = data else { return }
                
                let cacheResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cacheResponse, for: .init(url: imageURL))
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
