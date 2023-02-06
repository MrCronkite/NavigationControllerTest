//
//  ImageManager.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import Foundation
import UIKit



class ImageManager {
    
    var imageArray: ImageModel?
    var imagesString = [String]()
    var arreyImages = [UIImage?]()
    
    func makeRequest(_ searchString: String) {
        guard let url = URL(string: "https://serpapi.com/search.json?q=\(searchString)&tbm=isch&ijn=0&api_key=6d95ddf74dbc6609eca937f6b7050855ba9602e5e064d738db5e0e2833666b21") else { fatalError("Missing URL")}
               
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
    
    
    func asyncLoadImage(imageURL: URL,
                        runQueue: DispatchQueue,
                        completionQueue: DispatchQueue,
                        completion: @escaping (UIImage?, Error?) -> ()) {
        runQueue.async {
            print("_______________________\(imageURL)")
            do {
                let data = try Data(contentsOf: imageURL)
                completionQueue.async { completion(UIImage(data: data), nil)}
            } catch let error {
                completionQueue.async { completion(nil, error)}
            }
        }
    }
    
    func asyncGroup(){
        guard let arrey = imageArray?.imagesResults else {return}
        for i in arrey {
            self.imagesString.append(i.link)
        }
        for i in 0...10 {
         asyncLoadImage(imageURL: URL(string: self.imagesString[i])!,
                           runQueue: DispatchQueue.global(),
                           completionQueue: DispatchQueue.main)
            { result, error in
                guard let image1 = result else {return}
               // self.arreyImages.append(image1)
            }
        }
        print(self.arreyImages)
    }
    
    func asyncUsual (){
        guard let arrey = imageArray?.imagesResults else {return}
        for i in arrey {
            self.imagesString.append(i.link)
        }
        
        for i in 0...20 {
            let url = URL(string: self.imagesString[i])
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) -> Void in
                DispatchQueue.main.async {
                    guard let data1 = data else {return}
                    self.arreyImages.append(UIImage(data: data1))
                }
            }
            task.resume()
        }
    }

    
    
}
