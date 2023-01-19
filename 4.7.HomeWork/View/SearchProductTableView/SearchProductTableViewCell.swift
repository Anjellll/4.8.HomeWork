//
//  SearchProductTableViewCell.swift
//  4.7.HomeWork
//
//  Created by anjella on 20/1/23.
//

import UIKit

class SearchProductTableViewCell: UITableViewCell {

    public static let reuseID = String(describing: SearchProductTableViewCell.self)
    
    @IBOutlet private weak var productIcon: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productDescriptionLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productRatingLabel: UILabel!
    @IBOutlet private weak var productBrandLabel: UILabel!
    @IBOutlet private weak var productStockLabel: UILabel!
    
    func configureCellBeforeShowing(phone: ProductDataModel) {
        guard let imageURLPath = URL(string: phone.thumbnail) else {
            print("Incorrect url for image url path")
            return
        }
        
        downloadImage(from: imageURLPath, to: self.productIcon)
        productTitleLabel.text = phone.title
        productDescriptionLabel.text = phone.description
        productPriceLabel.text = "\(phone.rating)"
        productBrandLabel.text = phone.brand
        productPriceLabel.text = "\(phone.price) $"
    }
}

extension SearchProductTableViewCell {
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL, to imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
