//
//  PlanetCell.swift
//  SWPlanets
//
//  Created by Wimansha Chathuranga on 2022-09-26.
//

import UIKit
import SDWebImage

class PlanetCell: UITableViewCell {
    
    //MARK: --- Constants ---
    
    static let identifier = "LessonCell"
    
    //MARK: --- Private Properties ---
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var climateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "right_arrow")
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    private lazy var seperatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#262627")
        return view
    }()
    
    //MARK: --- Public Methods ---
    
    func set(planet : Planet, imageId: Int){
        nameLabel.text = planet.name
        climateLabel.text = planet.climate
        thumbImageView.sd_setImage(with: planet.thumbnailURL, completed: nil)
    }
    
    //MARK: --- Inits ---
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Private Methods ---
    
    private func configure(){
        self.selectionStyle = .none
        
        self.clipsToBounds = true
        backgroundColor = UIColor(hexString: "#1D1D1D")
        self.contentView.backgroundColor = backgroundColor
        
        self.contentView.addSubview(thumbImageView)
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(climateLabel)
        climateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(arrowImageView)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(seperatorLine)
        seperatorLine.translatesAutoresizingMaskIntoConstraints = false
                
        let margin : CGFloat = 10
        
        NSLayoutConstraint.activate([
            thumbImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            thumbImageView.widthAnchor.constraint(equalTo: thumbImageView.heightAnchor, multiplier: 1.5),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: margin),
            //nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            climateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0),
            climateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            //climateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor,  multiplier: 0.3),
            arrowImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: margin),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            arrowImageView.widthAnchor.constraint(equalTo: arrowImageView.heightAnchor),
            
            seperatorLine.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            seperatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            seperatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            seperatorLine.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    //MARK: --- Overrides ---
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
