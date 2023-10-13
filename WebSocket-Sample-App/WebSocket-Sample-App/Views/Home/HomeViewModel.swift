//
//  HomeViewModel.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import Foundation

protocol HomeViewModelRepresentable {
    
    func loadData()
}

final class HomeViewModel<R: AppRouter> { 
    
    private let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    
    func loadData() {
        ///
    }
}
