//
//  ImageCarouselController.swift
//  testTask
//
//  Created by admin1 on 8.02.23.
//

import UIKit

class ImageCarouselController: UIViewController {
    

    @IBOutlet weak var imageViewCarousel: UIImageView!
    var numberCell: Int = 0
    var data: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
   
    @IBAction func buttonPrev(_ sender: Any) {
        numberCell -= 1
        imageViewCarousel.image = UIImage(data: data[numberCell])
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        numberCell += 1
        imageViewCarousel.image = UIImage(data: data[numberCell])
    }
}
