//
//  ViewController.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit

class MainViewController: UIViewController {
    
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

}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        print(filterImage)
        
    }
    
    private func filterContentForSearchText(_ searchImage: String) {
        filterImage = filter.filter {$0 == searchImage}
    }

}

