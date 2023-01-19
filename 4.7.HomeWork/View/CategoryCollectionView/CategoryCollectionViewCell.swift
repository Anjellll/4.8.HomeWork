//
//  CategoryCollectionView.swift
//  4.7.HomeWork
//
//  Created by anjella on 16/1/23.


import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    public static let reusedID = String(describing: CategoryCollectionViewCell.self)
    @IBOutlet private weak var categoryCustomView: UIView!
    @IBOutlet private weak var imageIconImage: UIImageView!
    @IBOutlet private weak var dataHorizantallyLabel: UILabel!
    
    func display(item: CategoryDataModel, selected: CategoryDataModel) {
        dataHorizantallyLabel.textColor = isSelected ? UIColor.white : UIColor.black
        dataHorizantallyLabel.text = item.dataHorizantally
        imageIconImage.image = item.imageView
    }
    
    @IBInspectable
    private var cornerRadius: CGFloat {
        get { self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    private var contentColor: UIColor {
        get { self.backgroundColor ?? .clear }
        set { self.backgroundColor = newValue }
    }
    
    @IBInspectable
    private var borderWidth: CGFloat {
        get { self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable
    private var borderColor: CGColor {
        get { self.layer.borderColor ?? UIColor.clear.cgColor }
        set { self.layer.borderColor = newValue }
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: CategoryCollectionViewCell.self), owner: self)
        addSubview(categoryCustomView)
        categoryCustomView.frame = bounds
        categoryCustomView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}


