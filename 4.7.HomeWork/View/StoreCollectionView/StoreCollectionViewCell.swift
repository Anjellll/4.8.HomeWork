//
//  StoreCollectionViewCell.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.
//

import UIKit

class StoreCollectionViewCell: UICollectionViewCell {
    public static let reusedID = String(describing: StoreCollectionViewCell.self)
    @IBOutlet private weak var storesImage: UIImageView!
    @IBOutlet private weak var storesNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
        func display(item: StoreDataModel) {
            storesImage.image = item.imageView
            storesNameLabel.text = item.storesName
        }
}

