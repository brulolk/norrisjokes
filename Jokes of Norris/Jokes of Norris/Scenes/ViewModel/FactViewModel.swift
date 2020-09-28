//
//  ListViewModel.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 25/09/20.
//

import Foundation

protocol FactViewModelProtocol {
    func reloadTableView()
}

final class FactViewModel {
    
    var facts: [Fact] = []
    let title = "CHUCK NORRIS FACTS"
    var messageOfSearch = ""
    var coordinator: ListViewCoordinator!
    var viewController: BaseViewController!
    var delegate: FactViewModelProtocol!
    
    init(viewController: BaseViewController, delegate: FactViewModelProtocol) {
        self.delegate = delegate
        self.viewController = viewController
    }
    
    func tappedSearch() {
        coordinator.goSearch(viewModel: self)
    }
    
    func getFacts(search: String, category: String) {
        if search.count > 0 {
            self.viewController.showProgress()
            self.facts.removeAll()
            MyHistory.setSearchTerm(term: search)
            DataService.shared.searchFacts(search: search) { (result, error) in
                self.viewController.hideProgress()
                if let error = error {
                    self.viewController.showErrorMessage("Erro", message: error, duration: 2.0)
                    self.messageOfSearch = "We had an error, please try again"
                    self.delegate.reloadTableView()
                } else {
                    if result.isEmpty {
                        self.viewController.showErrorMessage("Not Found", message: "There are no results for this search: \(search)", duration: 2.0)
                        self.messageOfSearch = "There are no results for this search: \(search)"
                        self.delegate.reloadTableView()
                    } else {
                        self.facts = result
                        self.delegate.reloadTableView()
                    }
                }
            }
        } else if category.count > 0 {
            self.viewController.showProgress()
            self.facts.removeAll()
            DataService.shared.searchForCategory(category: category) { (result, error) in
                self.viewController.hideProgress()
                if let error = error {
                    self.viewController.showErrorMessage("Erro", message: error, duration: 2.0)
                    self.messageOfSearch = "We had an error, please try again"
                    self.delegate.reloadTableView()
                } else {
                    if result == nil {
                        self.viewController.showErrorMessage("Not Found", message: "There are no results for this category: \(category)", duration: 2.0)
                        self.messageOfSearch = "There are no results for this category: \(category)"
                        self.delegate.reloadTableView()
                    } else {
                        self.facts.append(result!)
                        self.delegate.reloadTableView()
                    }
                }
            }
        }
    }
    
    func getCategories() {
        DataService.shared.searchCategories { (categories, error) in
            if let error = error {
                self.viewController.showErrorMessage("Erro", message: error, duration: 2.0)
            } else {
                if categories.isEmpty {
                    self.viewController.showErrorMessage("Not Found", message: "Nothing found categories", duration: 2.0)
                } else {
                    MyHistory.setCategories(categorys: categories)
                }
            }
        }
    }
    
}
