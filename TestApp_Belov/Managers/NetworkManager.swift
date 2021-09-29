//
//  NetworkManager.swift
//  TestApp_Belov
//
//  Created by Владислав Белов on 29.09.2021.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
    private let baseURL = "https://pixabay.com/api/?key=23615708-2d50648341163a57c2fba8ad0&q=pugs&image_type=photo&pretty=true"
    
    let cache = NSCache<NSString, UIImage>()
    
    func getPhotos(completion: @escaping(Result<Image, VBError>) -> Void){
        guard let url = URL(string: baseURL) else
         { completion(.failure(.unableToComplete))
            return
         }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            print(data.debugDescription)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let imageData = try decoder.decode(Image.self, from: data)
                completion(.success(imageData))
            } catch {
                print(error)
                completion(.failure(.invalidData))
                return
            }
            
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200, let data = data,
                  let image = UIImage(data: data) else {
                      completion(nil)
                      return
                  }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}


