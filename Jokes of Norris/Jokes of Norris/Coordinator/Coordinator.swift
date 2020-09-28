//
//  Coordinator.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 26/09/20.
//

import UIKit

protocol CoordinatorDelegate: class {
    func coordinatorDidExit(_ coordinator: Coordinator)
}

protocol Coordinator: CoordinatorDelegate {
    var coordinatorDelegate: CoordinatorDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    
    func coordinatorDidExit(_ coordinator: Coordinator) {
        guard let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        self.childCoordinators.remove(at: index)
    }
}

