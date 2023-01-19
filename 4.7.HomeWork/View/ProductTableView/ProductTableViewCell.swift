//
//  ProductTableViewCell.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    public static let reuseID = String(describing: ProductTableViewCell.self)
    
    @IBOutlet private  weak var productIconView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var brandNameLabel: UILabel!
    @IBOutlet private weak var stockLabel: UILabel!
    
    func display(item: ProductDataModel) {
        guard let imageURLPath = URL(string: item.thumbnail) else {
            print("Incorrect url for image url path")
            return
        }
        
        downloadImage(from: imageURLPath, to: self.productIconView)
        productNameLabel.text = item.title
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.price)"
        discountLabel.text = "\(item.discountPercentage)"
        ratingLabel.text = "\(item.rating)"
        stockLabel.text = "\(item.stock)"
    }
    
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
