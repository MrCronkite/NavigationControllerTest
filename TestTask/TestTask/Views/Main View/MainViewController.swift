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
    var alert = UIAlertController()
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}


extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        let engCharacters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
        if text == text.filter({engCharacters.contains($0)}){
            imageManager.makeRequest(text)
        } else {
            alert = UIAlertController(title: "Неверный текст", message: "Введите текст используя английскую клавиатуру, не используйте пробелы и другие символы", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            self.present(alert, animated: true)
        }
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(4)) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageManager.arreyImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        contCell.imageView.image = UIImage(data: self.imageManager.arreyImages[indexPath.row])
        return contCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ImageCarouselStoryboard", bundle: nil)
        guard let imageCarouselVC = storyboard.instantiateViewController(withIdentifier: "ImageCarousel") as? ImageCarouselController else { return }
        imageCarouselVC.data = self.imageManager.arreyImages
        imageCarouselVC.numberCell = indexPath.row
        imageCarouselVC.arreyData = (imageManager.imageArray!.imagesResults)
        show(imageCarouselVC, sender: nil)
    }
}

