//
//  HomeViewModel.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import Combine
import Foundation

protocol HomeViewModelRepresentable {
    
    var counterValueSubject: CurrentValueSubject<Double, Error> { get }
    
    func loadData()
}

final class HomeViewModel<R: AppRouter> { 
    
    private let router: R
    
    private var counterEmited: Double = 0.0 {
        didSet {
            counterValueSubject.send(counterEmited)
        }
    }
    
    internal var counterValueSubject: CurrentValueSubject<Double, Error> = .init(0)
    
    init(router: R) {
        self.router = router
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    
    func loadData() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [unowned self] _ in
            counterEmited = Double.random(in: 20000...30000)
        }
    }
}
