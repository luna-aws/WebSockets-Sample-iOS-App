//
//  HomeViewModel.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import Combine
import Foundation

protocol HomeViewModelRepresentable {
    
    var counterValueSubject: CurrentValueSubject<String, Error> { get }
    
    func loadData()
}

final class HomeViewModel<R: AppRouter> { 
    
    private let router: R
    private let store: WebSocketStore
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    private var counterEmited: String = "0.0" {
        didSet {
            counterValueSubject.send(counterEmited)
            loadData()
        }
    }
    
    internal var counterValueSubject: CurrentValueSubject<String, Error> = .init("0")
    
    init(router: R, store: WebSocketStore = APIManager()) {
        self.router = router
        self.store = store
        self.store.startService()
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    
    func loadData() {
        Task {
            switch try await store.listenService() {
                case .data(let data): counterValueSubject.send(data.description)
                    
                case .string(let string): counterEmited = string
                    
                @unknown default: counterValueSubject.send(completion: .failure(APIError.unknownError))
            }
        }
        .cancel()
    }
}
