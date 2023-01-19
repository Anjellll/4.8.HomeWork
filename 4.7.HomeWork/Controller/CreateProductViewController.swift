//
//  CreateProductViewController.swift
//  4.7.HomeWork
//
//  Created by anjella on 20/1/23.
//

import UIKit

class CreateProductViewController: UIViewController {
    
    @IBOutlet weak var nameTextFieldq: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
   }
    
    @IBAction private func createTapped(_sender: UIButton) {
        guard let name = nameTextFieldq.text,
              !name.isEmpty,
           let description = descriptionTextField.text,
              !description.isEmpty,
           let category = categoryTextField.text,
              !category.isEmpty,
           let brand = brandTextField.text,
                 !brand.isEmpty else {
            showFillAlert()
            return
        }
        
        let user = ProductDataModel(title: name, description: description, brand: brand, category: category, thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", id: 100, price: 100, stock: 12, discountPercentage: 25.25, rating: 23.324)
        NetworkLayer.shared.createProduct(with: user)
    }
    
    func showFillAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Вы не заполнили все поля", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
