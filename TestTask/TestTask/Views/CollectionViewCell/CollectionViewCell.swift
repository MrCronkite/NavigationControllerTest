//
//  CollectionViewCell.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configure(with countryName: Int) {
        label.text = String(countryName)
    }
    
}
