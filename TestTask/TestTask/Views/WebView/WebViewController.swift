//
//  WebViewViewController.swift
//  testTask
//
//  Created by admin1 on 8.02.23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRequest()
    }
    
    private func loadRequest(){
        guard let url = URL(string: link) else {return}
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
