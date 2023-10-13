//
//  App.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit

final class App {
    
    var navController: UINavigationController = .init()
}

extension App: AppRouter {
    
    func process(route: AppTransition) {
        let coordinator = route.coordinatorFor(router: self)
        coordinator.start()
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
