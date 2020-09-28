//
//  SearchViewController.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var factViewModel: FactViewModel!
    
    var lastTerms:[Any] = MyHistory.getSearchTerms(inverted: true)
    var categories:[Any] = MyHistory.getCategories()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SearchViewController: SearchTermDelegate {
    
    func searchTerm(term: String) {
        factViewModel.getFacts(search: term, category: "")
        navigationController?.popViewController(animated: true)
    }
    
    func searchCategory(category: String) {
        factViewModel.getFacts(search: "", category: category)
        navigationController?.popViewController(animated: true)
    }
    
    func showMessageErro(message: String) {
        self.showAlert(title: "Erro", message: message)
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastTerms.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as? InputTableViewCell {
                cell.setupTextField()
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath)
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableViewCell {
                cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "sugestsCell", for: indexPath) as? SugestsTableViewCell {
                cell.textLabel!.text = self.lastTerms[indexPath.row-2] as! String
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "sugestsCell", for: indexPath)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 2 {
            self.searchTerm(term: self.lastTerms[indexPath.row-2] as! String)
        }
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath as IndexPath) as? CategoryCollectionViewCell {
            cell.setupCategory(category: self.categories[indexPath.row] as! String)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath as IndexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchCategory(category: categories[indexPath.row] as! String)
    }
    
}
