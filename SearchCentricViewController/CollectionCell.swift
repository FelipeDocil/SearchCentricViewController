//
//  SCVCollectionView.swift
//  SearchCentricViewController
//
//  Created by Felipe Docil on 10/12/16.
//  Copyright © 2016 Felipe Docil. All rights reserved.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = self.initialImageView()
    lazy var titleLabel: UILabel = self.initialTitleLabel()
    
    
    // MARK: - Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    func configureCell() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 8
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        imageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    func displayData(dataSourceObject: DataSourceObject) {
        imageView.image = dataSourceObject.image
        
        titleLabel.text = dataSourceObject.title
    }
    
    
    // MARK - Lazy instantiation
    func initialImageView() -> UIImageView {
        let tempImageView = UIImageView()
        
        return tempImageView
    }
    
    func initialTitleLabel() -> UILabel {
        let tempLabel = UILabel()
        
        return tempLabel
    }
}
