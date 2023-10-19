//
//  Router.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit

protocol Router {
    
    associatedtype Route
    
    var navController: UINavigationController { get set }
    
    func process(route: Route)
    func exit()
}

protocol AppRouter: Router where Route == AppTransition { }
