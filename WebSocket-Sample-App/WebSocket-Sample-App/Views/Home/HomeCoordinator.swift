//
//  HomeCoordinator.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit

final class HomeCoordinator<R: AppRouter> {
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = HomeViewModel(router: router)
        let viewController = HomeView(viewModel: viewModel)
        return viewController
    }()
}

extension HomeCoordinator: Coordinator {
    
    func start() {
        router.navController.pushViewController(primaryViewController, animated: true)
    }
}
