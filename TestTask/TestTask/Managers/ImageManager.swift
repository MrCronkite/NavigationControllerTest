//
//  ImageManager.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import Foundation
import UIKit



final class ImageManager {
    
    var imagesModel: ImageModel?
    var imagesString = [String]()
    var arreyImages = [Data]()
    
    let keyApi = "6d95ddf74dbc6609eca937f6b7050855ba9602e5e064d738db5e0e2833666b21"
    
    func makeRequest(_ searchString: String) {
        guard let url = URL(string: "https://serpapi.com/search.json?q=\(searchString)&tbm=isch&ijn=0&api_key=\(keyApi)") else { fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let tasl = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            self.imagesModel = nil
            self.arreyImages = []
            self.imagesString = []
            if let data = data, let decodeData = try? JSONDecoder().decode(ImageModel.self, from: data){
                DispatchQueue.main.async {
                    self.imagesModel = decodeData
                }
            }
        }
        tasl.resume()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)){
            self.asyncUsual()
        }
    }
    
    func asyncUsual (){
        guard let arrey = imagesModel?.imagesResults else {return}
        for i in arrey {
            self.imagesString.append(i.thumbnail)
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)){
            for i in 0...(self.imagesString.count - 1) {
                let url = URL(string: self.imagesString[i])
                let request = URLRequest(url: url!)
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        self.arreyImages.append(data!)
                    }
                }
                task.resume()
            }
        }
    }
}

