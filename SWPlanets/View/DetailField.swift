//
//  DetailField.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import UIKit

class DetailField : UIView {
    
    //MARK: --- Properties ---
    
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    //MARK: --- Inits ---
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Public Methods ---
    
    public func set(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = value
    }
    
    //MARK: --- Setup ---
    
    func setup() {
        self.addSubview(keyLabel)
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyLabel.topAnchor.constraint(equalTo: topAnchor),
            keyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            keyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 2),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
