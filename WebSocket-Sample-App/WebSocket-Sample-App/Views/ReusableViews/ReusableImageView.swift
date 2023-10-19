//
//  ReusableImageView.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/18/23.
//

import UIKit

final class ReusableImageView: UIImageView {
    
    init(coinType: Coin) {
        super.init(image: Self.getImage(coinType))
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private static func getImage(_ type: Coin) -> UIImage {
        switch type {
            case .bitcoin: return #imageLiteral(resourceName: "BitcoinIcon")
            case .ethereum: return #imageLiteral(resourceName: "EthereumIcon")
            case .monero: return #imageLiteral(resourceName: "MoneroIcon")
            case .litecoin: return #imageLiteral(resourceName: "LitecoinIcon")
        }
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
        contentMode = .scaleAspectFit
    }
    
    func changeValueAnimation(isMinor: Bool) {
        UIView.animate(withDuration: 0.25) { [unowned self] in
            layer.borderColor = isMinor ? UIColor.red.cgColor : UIColor.green.cgColor
            layer.borderColor = UIColor.clear.cgColor
        }
    }
}
