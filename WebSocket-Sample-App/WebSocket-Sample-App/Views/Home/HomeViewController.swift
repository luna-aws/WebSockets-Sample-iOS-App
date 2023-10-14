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
    
    private var subscriber: AnyCancellable?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "BitcoinIcon")
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "Algerian", size: 20)
        label.text = "1000.0"
        return label
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
        
        view.addSubview(imageView)
        
        imageView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.4),
            
            countLabel.bottomAnchor.constraint(equalTo: countLabel.superview!.bottomAnchor, constant: -20),
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func bindUI() {
        
        viewModel.loadData()
        
        subscriber = viewModel.counterValueSubject
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
                    imageView.layer.borderColor = newValue > currentValue ? UIColor.green.cgColor : UIColor.red.cgColor
                    imageView.layer.borderColor = UIColor.clear.cgColor
                    countLabel.text = newValue
                }
            })
    }
}
