//
//  CollectionViewCell.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    let imageManager = ImageManager()
    
    @IBOutlet weak var imageView2: UIImageView!
    func fetchImage(_ urlString: String) {
        let url = URL(string: urlString)!
        imageManager.asyncLoadImage(imageURL: url, runQueue: DispatchQueue.global(qos: .userInitiated), complitionQueue: DispatchQueue.main) { result, error in
            guard let image = result else {return}
            self.imageView.image = image
            self.imageView2.image = image
        }
    }
}
