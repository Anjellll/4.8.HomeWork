//
//  SearchViewController.swift
//  4.7.HomeWork
//
//  Created by anjella on 20/1/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchTableView: UITableView!
    
    private var products: [ProductDataModel] = []
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUpProducts()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setUpSearchBar() {
        view.addSubview(searchBar)
//        searchBar.delegate = self
    }
    
    private func configureTableView() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(
            UINib(
                nibName: String(describing: SearchProductTableViewCell.self),
                bundle: nil),
            forCellReuseIdentifier: SearchProductTableViewCell.reuseID)
    }
    
    private func fetchUpProducts() {
        NetworkLayer.shared.fetchProducts { [weak self] result in
            guard let `self` = self else { return }
            if case .success(let products) = result {
                DispatchQueue.main.async {
                    self.products = products
                    self.searchTableView.reloadData()
                }
            }
        }
    }
    
    private func deleteProduct(by id: Int) {
        NetworkLayer.shared.deleteUser(by: id)
    }
    
    private func handleDeleteUser(indexPath: IndexPath) {
        let id = products[indexPath.row].id
        deleteProduct(by: id)
        products.remove(at: indexPath.row)
        searchTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchProductTableViewCell.reuseID, for: indexPath) as! SearchProductTableViewCell
        let model = products[indexPath.row]
        cell.configureCellBeforeShowing(phone: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            handleDeleteUser(indexPath: indexPath)
        }
    }
}




