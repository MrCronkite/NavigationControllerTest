//
//  ViewController.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit


class MainViewController: UIViewController {
    
    let imageManager = ImageManager()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        
        collectionView.dataSource = self
    }

}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        imageManager.makeRequest(searchController.searchBar.text!)
        collectionView.reloadData()
        
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageManager.imageArray?.imagesResults.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let contCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            contCell.fetchImage(imageManager.imageArray?.imagesResults[indexPath.row].link ?? "")
            
            cell = contCell
        }
        
        return cell
        
    }
    
    
}

