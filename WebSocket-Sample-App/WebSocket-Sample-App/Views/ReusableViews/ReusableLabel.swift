//
//  ReusableLabel.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/18/23.
//

import UIKit

final class ReusableLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 1
        textColor = .label
        textAlignment = .center
        font = UIFont(name: "Algerian", size: 20)
        text = "0.0"
    }
}
