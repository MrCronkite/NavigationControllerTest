//
//  ImageManager.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import Foundation



class ImageManager {
    
    var imageArray: ImageModel?
    
    func makeRequest(_ searchString: String) {
        guard let url = URL(string: "https://serpapi.com/search.json?q=\(searchString)&tbm=isch&ijn=0&api_key=391c4a57b050893349857efc7ae37298ac1343f03a52173a99724686e687ff9c") else { fatalError("Missing URL")}
               
        let urlRequest = URLRequest(url: url)
        
        let tasl = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data, let decodeData = try? JSONDecoder().decode(ImageModel.self, from: data){
                DispatchQueue.main.async {
                    self.imageArray = decodeData
                }
            }
        }
        tasl.resume()
    }
}
