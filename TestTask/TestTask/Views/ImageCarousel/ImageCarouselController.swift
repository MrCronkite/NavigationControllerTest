//
//  ImageCarouselController.swift
//  testTask
//
//  Created by admin1 on 8.02.23.
//

import UIKit

class ImageCarouselController: UIViewController {
    
    var arreyData = [ImagesResult]()
    var numberCell: Int = 0
    var data: [Data] = []
    
    @IBOutlet weak var imageViewCarousel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !data.isEmpty {
            imageViewCarousel.image = UIImage(data: data[numberCell])
        }
        
    }
    
    @IBAction func showWebView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WebViewStoryboard", bundle: nil)
        guard let webViewVC = storyboard.instantiateViewController(identifier: "WebViewID") as? WebViewController else {return}
        webViewVC.link = arreyData[self.numberCell].link
        present(webViewVC, animated: true)
    }
    
    @IBAction func buttonPrev(_ sender: Any) {
        if numberCell == 0 {
            numberCell = data.count
        }
        numberCell -= 1
        imageViewCarousel.image = UIImage(data: data[numberCell])
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        numberCell += 1
        if numberCell == data.count {
            numberCell = 0
        }
        imageViewCarousel.image = UIImage(data: data[self.numberCell])
    }
}
