//
//  ListViewCoordinator.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

class ListViewCoordinator: Coordinator {
    
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let listViewController = storyboard.instantiateViewController(withIdentifier:
            "ListViewControllerID") as? ListViewController {
            let factViewModel = FactViewModel(viewController: listViewController, delegate: listViewController)
            listViewController.factViewModel = factViewModel
            listViewController.baseDelegate = self
            factViewModel.viewController = listViewController
            factViewModel.coordinator = self
            self.navigationController.pushViewController(listViewController, animated: true)
        }
    }
    
    //MARK: - Navigation
    
    func goSearch(viewModel: FactViewModel) {
        let search = SearchViewCoordinator(navigationController: navigationController)
        search.start(viewModel: viewModel)
        childCoordinators.append(search)
    }
    
}

// MARK: - BaseViewControllerDelegate

extension ListViewCoordinator: BaseViewControllerDelegate {

    func viewControllerDidExit(_ viewController: UIViewController) {
        coordinatorDelegate?.coordinatorDidExit(self)
    }
}
