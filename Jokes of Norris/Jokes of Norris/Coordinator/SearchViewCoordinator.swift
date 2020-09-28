//
//  SearchViewController.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

class SearchViewCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationViewController

    // MARK: - Init

    init(navigationController: BaseNavigationViewController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    func start() {
        
    }
    
    func start(viewModel: FactViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let searchViewController = storyboard.instantiateViewController(withIdentifier:
            "SearchViewControllerID") as? SearchViewController {
            searchViewController.factViewModel = viewModel
            searchViewController.baseDelegate = self
            self.navigationController.pushViewController(searchViewController, animated: true)
        }
    }
    
}

// MARK: - BaseViewControllerDelegate

extension SearchViewCoordinator: BaseViewControllerDelegate {

    func viewControllerDidExit(_ viewController: UIViewController) {
        coordinatorDelegate?.coordinatorDidExit(self)
    }
}
