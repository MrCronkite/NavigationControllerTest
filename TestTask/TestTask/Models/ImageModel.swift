//
//  ImageModel.swift
//  testTask
//
//  Created by admin1 on 5.02.23.
//

import Foundation

// MARK: - ImageModel
struct ImageModel: Codable {
    let imagesResults: [ImagesResult]
    
    enum CodingKeys: String, CodingKey {
        case imagesResults = "images_results"
    }
}

// MARK: - ImagesResult
struct ImagesResult: Codable {
    let position: Int
    let thumbnail: String
    let source, title: String
    let link: String
    let original: String
    let originalWidth, originalHeight: Int
    let isProduct: Bool
    let inStock: Bool?
    
    enum CodingKeys: String, CodingKey {
        case position, thumbnail, source, title, link, original
        case originalWidth = "original_width"
        case originalHeight = "original_height"
        case isProduct = "is_product"
        case inStock = "in_stock"
    }
}
