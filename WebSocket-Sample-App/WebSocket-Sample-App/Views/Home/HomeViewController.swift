//
//  HomeViewController.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit
import Combine

final class HomeView<ViewModel: HomeViewModelRepresentable>: UIViewController {
    
    private let viewModel: ViewModel
    
    private var anyCancellables: Set<AnyCancellable> = .init()
    
    private lazy var bitcoinImageView = ReusableImageView(coinType: .bitcoin)
    private lazy var bitcoinCounterLabel = ReusableLabel()
    
    private lazy var ethereumImageView = ReusableImageView(coinType: .ethereum)
    private lazy var ethereumCounterLabel = ReusableLabel()
    
    private lazy var moneroImageView = ReusableImageView(coinType: .monero)
    private lazy var moneroCounterLabel = ReusableLabel()
    
    private lazy var litecoinImageView = ReusableImageView(coinType: .litecoin)
    private lazy var litecoinCounterLabel = ReusableLabel()
    
    private lazy var containerView: UIView = {
        let stackView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
    }
    
    private func setupUI() {
        title = "Web Socket iOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        
        containerView.addSubview(bitcoinImageView)
        bitcoinImageView.addSubview(bitcoinCounterLabel)
        
        containerView.addSubview(ethereumImageView)
        ethereumImageView.addSubview(ethereumCounterLabel)
        
        containerView.addSubview(moneroImageView)
        moneroImageView.addSubview(moneroCounterLabel)
        
        containerView.addSubview(litecoinImageView)
        litecoinImageView.addSubview(litecoinCounterLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            containerView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.7),
            
            /// Bitcoin
            
            bitcoinImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            bitcoinImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            bitcoinImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            bitcoinImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            bitcoinCounterLabel.centerXAnchor.constraint(equalTo: bitcoinImageView.centerXAnchor),
            bitcoinCounterLabel.bottomAnchor.constraint(equalTo: bitcoinImageView.bottomAnchor, constant: -10),
            
            /// Ethereoum
            
            ethereumImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            ethereumImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            ethereumImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            ethereumImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            
            ethereumCounterLabel.centerXAnchor.constraint(equalTo: ethereumImageView.centerXAnchor),
            ethereumCounterLabel.bottomAnchor.constraint(equalTo: ethereumImageView.bottomAnchor, constant: -10),
            
            /// Monero
            
            moneroImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            moneroImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            moneroImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            moneroImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            moneroCounterLabel.centerXAnchor.constraint(equalTo: moneroImageView.centerXAnchor),
            moneroCounterLabel.bottomAnchor.constraint(equalTo: moneroImageView.bottomAnchor, constant: -10),
            
            /// Litecoin
            
            litecoinImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            litecoinImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.4),
            litecoinImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            litecoinImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            litecoinCounterLabel.centerXAnchor.constraint(equalTo: litecoinImageView.centerXAnchor),
            litecoinCounterLabel.bottomAnchor.constraint(equalTo: litecoinImageView.bottomAnchor, constant: -10)
            
        ])
    }
    
    private func bindUI() {
        
        viewModel.loadData()
        
        viewModel.bitcoinValueSubject
            .receive(on: DispatchQueue.main)
            .scan((previous: "0.0", current: "0.0"), { accumulator, newValue in
                (previous: accumulator.current, current: newValue)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: print("Value Received!")
                    case .failure(let failure): print(failure.localizedDescription)
                }
            }, receiveValue: { [unowned self] currentValue, newValue in
                bitcoinImageView.changeValueAnimation(isMinor: newValue < currentValue)
                bitcoinCounterLabel.text = newValue
            })
            .store(in: &anyCancellables)
        
        viewModel.ethereumValueSubject
            .receive(on: DispatchQueue.main)
            .scan((previous: "0.0", current: "0.0"), { accumulator, newValue in
                (previous: accumulator.current, current: newValue)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: print("Value Received!")
                    case .failure(let failure): print(failure.localizedDescription)
                }
            }, receiveValue: { [unowned self] currentValue, newValue in
                ethereumImageView.changeValueAnimation(isMinor: newValue < currentValue)
                ethereumCounterLabel.text = newValue
            })
            .store(in: &anyCancellables)
        
        viewModel.moneroValueSubject
            .receive(on: DispatchQueue.main)
            .scan((previous: "0.0", current: "0.0"), { accumulator, newValue in
                (previous: accumulator.current, current: newValue)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: print("Value Received!")
                    case .failure(let failure): print(failure.localizedDescription)
                }
            }, receiveValue: { [unowned self] currentValue, newValue in
                moneroImageView.changeValueAnimation(isMinor: newValue < currentValue)
                moneroCounterLabel.text = newValue
            })
            .store(in: &anyCancellables)
        
        viewModel.litecoinValueSubject
            .receive(on: DispatchQueue.main)
            .scan((previous: "0.0", current: "0.0"), { accumulator, newValue in
                (previous: accumulator.current, current: newValue)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished: print("Value Received!")
                    case .failure(let failure): print(failure.localizedDescription)
                }
            }, receiveValue: { [unowned self] currentValue, newValue in
                litecoinImageView.changeValueAnimation(isMinor: newValue < currentValue)
                litecoinCounterLabel.text = newValue
            })
            .store(in: &anyCancellables)
    }
}
