//
//  ViewController.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit


class MainViewController: UIViewController {
    
  
   private var imageArray: ImageModel?
    
   private let searchController = UISearchController(searchResultsController: nil)
   private var filterImage = [String]()
   private var filter = ["Vlad", "Dima", "Pasha", "Doma"]
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
        guard let url = URL(string: "https://serpapi.com/search.json?engine=google&q=\(searchString)&gl=ru&gl=en&tbm=isch&start=0&num=20&ijn=0&tbs=m&") else { fatalError("Missing URL")}
               
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
        filterContentForSearchText(searchController.searchBar.text!)
        makeRequest(searchController.searchBar.text!)
        print(imageArray as Any)
        
    }
    
    private func filterContentForSearchText(_ searchImage: String) {
      
        filterImage = filter.filter {$0 == searchImage}
    }

}

