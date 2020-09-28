//
//  AppCoordinator.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationViewController
    private let window: UIWindow

    init(window: UIWindow) {
        self.navigationController = BaseNavigationViewController()
        self.window = window
    }

    func start() {
        showList()
    }

    func showList() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let list = ListViewCoordinator(navigationController: navigationController)
        list.start()
        childCoordinators.append(list)
    }

}

// MARK: - BaseViewControllerDelegate

extension AppCoordinator: BaseViewControllerDelegate {

    func viewControllerDidExit(_ viewController: UIViewController) {
        coordinatorDelegate?.coordinatorDidExit(self)
    }
}



