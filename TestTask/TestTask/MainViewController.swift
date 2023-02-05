//
//  ViewController.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit


class MainViewController: UIViewController {
    
   @IBOutlet weak var colletionView: UICollectionView!
    
   private var imageArray: ImageModel?
    
   private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
    }
    
    private func makeRequest(_ searchString: String) {
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

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        makeRequest(searchController.searchBar.text!)
        print(imageArray?.imagesResults.count as Any)
        
    }
}

