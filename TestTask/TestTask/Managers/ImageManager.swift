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
    var arreyImages = [Data]()
    
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
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)){
            self.asyncUsual()
        }
    }
    
    
    func asyncUsual (){
        guard let arrey = imageArray?.imagesResults else {return}
        for i in arrey {
            self.imagesString.append(i.link)
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)){
            for i in 0...20 {
                let url = URL(string: self.imagesString[i])
                let request = URLRequest(url: url!)
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        self.arreyImages.append(data!)
                        print(self.arreyImages)
                    }
                }
                task.resume()
            }
        }
    }
}

