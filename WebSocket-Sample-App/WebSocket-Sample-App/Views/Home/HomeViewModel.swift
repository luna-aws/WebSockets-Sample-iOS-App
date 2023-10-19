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
    var bitcoinValueSubject: CurrentValueSubject<String, APIError> { get }
    var ethereumValueSubject: CurrentValueSubject<String, APIError> { get }
    var moneroValueSubject: CurrentValueSubject<String, APIError> { get }
    var litecoinValueSubject: CurrentValueSubject<String, APIError> { get }
    var serviceStateValueSubject: CurrentValueSubject<Bool, APIError> { get }
    
    func loadData()
    func saveCoinValues()
    func changeServiceState()
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
    
    private var serviceState: Bool = false {
        didSet {
            serviceState ? store.resumeService() : store.pauseService()
            serviceStateValueSubject.send(serviceState)
        }
    }
    
    internal var anyCancellables: Set<AnyCancellable> = .init()
    internal var bitcoinValueSubject: CurrentValueSubject<String, APIError> = .init("0")
    internal var ethereumValueSubject: CurrentValueSubject<String, APIError> = .init("0")
    internal var moneroValueSubject: CurrentValueSubject<String, APIError> = .init("0")
    internal var litecoinValueSubject: CurrentValueSubject<String, APIError> = .init("0")
    internal var serviceStateValueSubject: CurrentValueSubject<Bool, APIError> = .init(false)
    
    init(router: R, store: WebSocketStore = APIManager()) {
        self.router = router
        self.store = store
    }
    
    deinit {
        store.closeService()
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    
    func loadData() {
        Task {
            switch try await self.store.listenService() {
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
                        [bitcoinValueSubject, ethereumValueSubject, moneroValueSubject, litecoinValueSubject].forEach { valueSubject in
                            valueSubject.send(completion: .failure(.genericError(error)))
                        }
                    }
                    
                    loadData()
                    
                default: break
            }
        }
        .cancel()
    }
    
    func saveCoinValues() {
        
        for (index, valueEmited) in [bitcoinEmited, etheeumEmited, moneroEmited, litecoinEmited].enumerated() {
            UserDefaults.standard.setValue(valueEmited, forKey: Coin.allCases[index].rawValue)
        }
        
        store.pauseService()
        serviceState = false
    }
    
    func loadCoinValues() {
        bitcoinEmited = UserDefaults.standard.value(forKey: Coin.bitcoin.rawValue) as? String ?? "0"
        etheeumEmited = UserDefaults.standard.value(forKey: Coin.ethereum.rawValue)  as? String  ?? "0"
        moneroEmited = UserDefaults.standard.value(forKey: Coin.monero.rawValue)  as? String  ?? "0"
        litecoinEmited = UserDefaults.standard.value(forKey: Coin.litecoin.rawValue)  as? String  ?? "0"
    }
    
    func changeServiceState() {
        serviceState.toggle()
    }
}
