//
//  HomeViewModel.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import Combine
import Foundation

protocol HomeViewModelRepresentable {
    
    var anyCancellables: Set<AnyCancellable> { get set }
    var bitcoinValueSubject: CurrentValueSubject<String, Error> { get }
    var ethereumValueSubject: CurrentValueSubject<String, Error> { get }
    var moneroValueSubject: CurrentValueSubject<String, Error> { get }
    var litecoinValueSubject: CurrentValueSubject<String, Error> { get }
    
    func loadData()
}

final class HomeViewModel<R: AppRouter> { 
    
    private let router: R
    private let store: WebSocketStore
    
    private var bitcoinEmited: String = "0.0" {
        didSet {
            bitcoinValueSubject.send(bitcoinEmited)
        }
    }
    
    private var etheeumEmited: String = "0.0" {
        didSet {
            ethereumValueSubject.send(etheeumEmited)
        }
    }
    
    private var moneroEmited: String = "0.0" {
        didSet {
            moneroValueSubject.send(moneroEmited)
        }
    }
    
    private var litecoinEmited: String = "0.0" {
        didSet {
            litecoinValueSubject.send(litecoinEmited)
        }
    }
    
    internal var anyCancellables: Set<AnyCancellable> = .init()
    internal var bitcoinValueSubject: CurrentValueSubject<String, Error> = .init("0")
    internal var ethereumValueSubject: CurrentValueSubject<String, Error> = .init("0")
    internal var moneroValueSubject: CurrentValueSubject<String, Error> = .init("0")
    internal var litecoinValueSubject: CurrentValueSubject<String, Error> = .init("0")
    
    init(router: R, store: WebSocketStore = APIManager()) {
        self.router = router
        self.store = store
        self.store.startService()
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    
    func loadData() {
        Task {
            switch try await self.store.listenService() {
                case .data(_): break
                    
                case .string(let string): 
                    
                    guard let data = string.data(using: .utf8) else { fatalError() }
                    
                    do {
                        
                        let decodedData = try JSONDecoder().decode([String: String].self, from: data)
                        
                        if let bitcoinValue = decodedData[Coin.bitcoin.rawValue] {
                            bitcoinEmited = "\(Coin.bitcoin.rawValue): \(bitcoinValue)".capitalized
                        }
                        
                        if let etherumCoin = decodedData[Coin.ethereum.rawValue] {
                            etheeumEmited = "\(Coin.ethereum.rawValue): \(etherumCoin)".capitalized
                        }
                        
                        if let moneroCoin = decodedData[Coin.monero.rawValue] {
                            moneroEmited = "\(Coin.monero.rawValue): \(moneroCoin)".capitalized
                        }
                        
                        if let litecoin = decodedData[Coin.litecoin.rawValue] {
                            litecoinEmited = "\(Coin.litecoin.rawValue): \(litecoin)".capitalized
                        }
                        
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                    
                    loadData()
                    
                @unknown default: fatalError()
            }
        }
        .cancel()
    }
}
