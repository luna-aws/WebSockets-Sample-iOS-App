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
    
    private lazy var bitcoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "BitcoinIcon")
        return imageView
    }()
    
    private lazy var bitcoinCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "Algerian", size: 20)
        label.text = "1000.0"
        return label
    }()
    
    private lazy var ethereumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 5
        imageView.image = #imageLiteral(resourceName: "EthereumIcon")
        return imageView
    }()
    
    private lazy var ethereumCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "Algerian", size: 20)
        label.text = "1000.0"
        return label
    }()
    
    private lazy var moneroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "MoneroIcon")
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private lazy var moneroCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "Algerian", size: 20)
        label.text = "1000.0"
        return label
    }()
    
    private lazy var litecoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "LitecoinIcon")
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private lazy var litecoinCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "Algerian", size: 20)
        label.text = "1000.0"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
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
        
        view.addSubview(stackView)
        
        stackView.addSubview(bitcoinImageView)
        bitcoinImageView.addSubview(bitcoinCounterLabel)
        
        stackView.addSubview(ethereumImageView)
        ethereumImageView.addSubview(ethereumCounterLabel)
        
        stackView.addSubview(moneroImageView)
        moneroImageView.addSubview(moneroCounterLabel)
        
        stackView.addSubview(litecoinImageView)
        litecoinImageView.addSubview(litecoinCounterLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            stackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.7),
            
            /// Bitcoin
            
            bitcoinImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            bitcoinImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            bitcoinImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            bitcoinImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            
            bitcoinCounterLabel.centerXAnchor.constraint(equalTo: bitcoinImageView.centerXAnchor),
            bitcoinCounterLabel.bottomAnchor.constraint(equalTo: bitcoinImageView.bottomAnchor, constant: -10),
            
            /// Ethereoum
            
            ethereumImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            ethereumImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            ethereumImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            ethereumImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            
            ethereumCounterLabel.centerXAnchor.constraint(equalTo: ethereumImageView.centerXAnchor),
            ethereumCounterLabel.bottomAnchor.constraint(equalTo: ethereumImageView.bottomAnchor, constant: -10),
            
            /// Monero
            
            moneroImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            moneroImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            moneroImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            moneroImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            
            moneroCounterLabel.centerXAnchor.constraint(equalTo: moneroImageView.centerXAnchor),
            moneroCounterLabel.bottomAnchor.constraint(equalTo: moneroImageView.bottomAnchor, constant: -10),
            
            /// Litecoin
            
            litecoinImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4),
            litecoinImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            litecoinImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            litecoinImageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            
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
            }, receiveValue: { currentValue, newValue in
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    bitcoinImageView.layer.borderColor = newValue > currentValue ? UIColor.green.cgColor : UIColor.red.cgColor
                    bitcoinImageView.layer.borderColor = UIColor.clear.cgColor
                    bitcoinCounterLabel.text = newValue
                }
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
            }, receiveValue: { currentValue, newValue in
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    ethereumImageView.layer.borderColor = newValue > currentValue ? UIColor.green.cgColor : UIColor.red.cgColor
                    ethereumImageView.layer.borderColor = UIColor.clear.cgColor
                    ethereumCounterLabel.text = newValue
                }
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
            }, receiveValue: { currentValue, newValue in
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    moneroImageView.layer.borderColor = newValue > currentValue ? UIColor.green.cgColor : UIColor.red.cgColor
                    moneroImageView.layer.borderColor = UIColor.clear.cgColor
                    moneroCounterLabel.text = newValue
                }
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
            }, receiveValue: { currentValue, newValue in
                UIView.animate(withDuration: 0.5) { [unowned self] in
                    litecoinImageView.layer.borderColor = newValue > currentValue ? UIColor.green.cgColor : UIColor.red.cgColor
                    litecoinImageView.layer.borderColor = UIColor.clear.cgColor
                    litecoinCounterLabel.text = newValue
                }
            })
            .store(in: &anyCancellables)
    }
}
