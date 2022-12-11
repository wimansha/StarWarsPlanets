//
//  PlanetDetailViewController.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import UIKit
import SDWebImage

class PlanetDetailViewController : UIViewController {
    
    //MARK: --- Public Properties ---
    
    var planet : Planet
    
    //MARK: --- Private Properties ---
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 10.0
        stack.addArrangedSubview(nameDetailField)
        stack.addArrangedSubview(orbitalPeriodField)
        stack.addArrangedSubview(gravityField)
        return stack
    }()
    
    private lazy var nameDetailField: DetailField = {
        let field = DetailField()
        return field
    }()
    
    private lazy var orbitalPeriodField: DetailField = {
        let field = DetailField()
        return field
    }()
    
    private lazy var gravityField: DetailField = {
        let field = DetailField()
        return field
    }()
    
    //MARK: --- inits ---
    
    init(planet: Planet) {
        self.planet = planet
        super.init(nibName: nil, bundle: nil)
        setup()
        
        imageView.sd_setImage(with: planet.imageURL, completed: nil)
        nameDetailField.set(key: "Name : ", value: planet.name ?? "")
        orbitalPeriodField.set(key: "Orbital Period : ", value: planet.orbitalPeriod ?? "")
        gravityField.set(key: "Gravity : ", value: planet.gravity ?? "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Setup ---
    
    func setup() {
        view.backgroundColor = UIColor(hexString: "#1C1C1C")
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        let leftRightMargin: CGFloat = 10.0
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftRightMargin)
        ])
    }
    
}
