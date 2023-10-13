//
//  HomeViewController.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/12/23.
//

import UIKit

final class HomeView<ViewModel: HomeViewModelRepresentable>: UIViewController {
    
    private let viewModel: ViewModel
    
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
    }
    
    private func setupUI() {
        title = "Web Socket iOS"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .gray.withAlphaComponent(0.5)
    }
}
