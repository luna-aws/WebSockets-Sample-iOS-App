//
//  App.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit

final class App {
    
    var coordinatorRegister: [AppTransition: Coordinator] = [:]
    var navController: UINavigationController = .init()
}

extension App: AppRouter {
    
    func process(route: AppTransition) {
        let coordinator = route.hasState ? coordinatorRegister[route] : route.coordinatorFor(router: self)
        coordinatorRegister[route] = coordinator
        coordinator?.start()
        print(route.identifier)
    }
    
    func exit() {
        navController.popToRootViewController(animated: true)
    }
}

extension App: Coordinator {
    
    func start() {
        process(route: .showHome)
    }
}

extension App {
    
    func saveData() {
        guard let coordinator = coordinatorRegister[.showHome] as? HomeCoordinator<Self> else { return }
        
        coordinator.saveCoinValues()
    }
    
    func loadData() {
        guard let coordinator = coordinatorRegister[.showHome] as? HomeCoordinator<Self> else { return }
        
        coordinator.loadCoinValues()
    }
}
