//
//  AppTransition.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

enum AppTransition {
    
    case showHome
    
    var identifier: String { String(describing: self) }
    
    var hasState: Bool { false }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        switch self {
            case .showHome:
                return HomeCoordinator(router: router)
        }
    }
}
