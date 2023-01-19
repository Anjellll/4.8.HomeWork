//
//  ProductDataModel.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import UIKit

struct Products: Codable {
    var products: [ProductDataModel]
}

struct ProductDataModel: Codable {
    let title, description, brand, category, thumbnail: String
    let id, price,stock: Int
    let discountPercentage, rating: Double
}


