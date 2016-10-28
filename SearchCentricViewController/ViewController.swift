//
//  ViewController.swift
//  SearchCentricViewController
//
//  Created by Felipe Docil on 10/7/16.
//  Copyright © 2016 Felipe Docil. All rights reserved.
//

import UIKit

struct DataSourceObject {
    var image: UIImage?
    var title: String
    
    init(image: UIImage?, title: String) {
        self.image = image
        self.title = title
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var coverImageView: UIImageView = self.initialCoverImageView()
    lazy var logoImageView: UIImageView = self.initialLogoImageView()
    lazy var searchBar: UITextField = self.initialSearchBar()
    lazy var collectionView: UICollectionView = self.initialCollectionView()
    
    // Datasource
    var dataSource: [DataSourceObject]?
    
    // Colors
    lazy var collectionViewBackgroundColor: UIColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    lazy var searchBarBorderColor: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    lazy var searchIconTintColor: UIColor = UIColor(red: 139/255, green: 146/255, blue: 149/255, alpha: 1)
    
    // Text
    let placeholderSearchText: String = "What are you looking for?"
    let collectionViewCellIdentifier: String = "SCVCell"
    
    // Images
    let logoImage: UIImage? = UIImage(named: "logo.png")
    let coverImage: UIImage? = UIImage(named: "cover_photo_2.jpeg")
    
    // Constants
    let gridX: CGFloat = 3
    let gridY: CGFloat = 2
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let meat = DataSourceObject(image: UIImage(named: "icn_meat.png"), title: "Meat")
        let chicken = DataSourceObject(image: UIImage(named: "icn_chicken.png"), title: "Chicken")
        let fish = DataSourceObject(image: UIImage(named: "icn_fish.png"), title: "Fish")
        let appetizer = DataSourceObject(image: UIImage(named: "icn_appetizer.png"), title: "Appetizer")
        let vegan = DataSourceObject(image: UIImage(named: "icn_vegan.png"), title: "Vegan")
        let drinks = DataSourceObject(image: UIImage(named: "icn_drinks.png"), title: "Drinks")
        
        dataSource = [meat, chicken, fish, appetizer, vegan, drinks]
        
        setupElements()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Constraints
    func setupElements() {
        
        view.backgroundColor = collectionViewBackgroundColor
        
        view.addSubview(coverImageView)
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        coverImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        logoImageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 72)
        logoImageView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -72).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: (logoImage?.size.height)!).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: (logoImage?.size.width)!).isActive = true
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.centerYAnchor.constraint(equalTo: coverImageView.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 32).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.bringSubview(toFront: searchBar)
    }
    
    override func viewDidLayoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [collectionViewBackgroundColor.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0 , 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.frame = coverImageView.bounds
        
        coverImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        let picture = UIImage.from(color: UIColor.white)
        
        let size = logoImageView.frame.size
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContext(size)
        picture?.draw(in: rect)
        logoImage?.draw(in: rect, blendMode: .destinationOut, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        logoImageView.image = newImage
        
        let width = collectionView.frame.size.width / gridX
        let height = collectionView.frame.size.height / gridY
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        
        let clearCGColor = UIColor.clear.cgColor
        
        let verticalGradientLayer = CAGradientLayer()
        verticalGradientLayer.colors = [clearCGColor, clearCGColor, UIColor.black.cgColor, UIColor.black.cgColor, clearCGColor, clearCGColor]
        verticalGradientLayer.locations = [0.0, 0.05, 0.15, 0.85, 0.95, 1.0]
        verticalGradientLayer.frame = collectionView.bounds
        
        collectionView.layer.mask = verticalGradientLayer
        
        let horizontalGradientView = UIView()
        horizontalGradientView.backgroundColor = collectionViewBackgroundColor
        
        view.addSubview(horizontalGradientView)
        horizontalGradientView.translatesAutoresizingMaskIntoConstraints = false
        horizontalGradientView.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        horizontalGradientView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        horizontalGradientView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        horizontalGradientView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        
        let horizontalGradientLayer = CAGradientLayer()
        horizontalGradientLayer.colors = [UIColor.black.cgColor, UIColor.black.cgColor, clearCGColor, clearCGColor, UIColor.black.cgColor, UIColor.black.cgColor]
        horizontalGradientLayer.locations = [0.0, 0.01, 0.11, 0.89, 0.99, 1.0]
        horizontalGradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        horizontalGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        horizontalGradientLayer.frame = collectionView.bounds
        
        horizontalGradientView.layer.mask = horizontalGradientLayer
    }
    
    
    // MARK: - UICollectionView Delegate
    
    
    // MARK: UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(gridX) * Int(gridY)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! CollectionCell
        cell.backgroundColor = collectionViewBackgroundColor
        cell.layer.borderColor = searchBarBorderColor.cgColor
        cell.layer.borderWidth = 1
        
        if let dataSource = dataSource {
            cell.displayData(dataSourceObject: dataSource[indexPath.row])
        }
        return cell
    }
    
    
    // MARK: - Lazy Instantiation
    func initialCoverImageView() -> UIImageView {
        let tempImageView = UIImageView(image: coverImage)
        tempImageView.contentMode = .scaleAspectFill
        
        return tempImageView
    }
    
    func initialLogoImageView() -> UIImageView {
        
        let tempView = UIImageView()
        tempView.backgroundColor = UIColor.clear
        
        return tempView
    }
    
    func initialSearchBar() -> UITextField {
        let tempSearchBar = UITextField()
        tempSearchBar.placeholder = placeholderSearchText
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 68, height: 68))
        
        let searchImageView = UIImageView()
        searchImageView.image = UIImage(named: "icn_search.png")?.withRenderingMode(.alwaysTemplate)
        searchImageView.tintColor = searchIconTintColor
        searchImageView.contentMode = .scaleAspectFit
        
        leftView.addSubview(searchImageView)
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 24).isActive = true
        searchImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 8).isActive = true
        searchImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -24).isActive = true
        
        tempSearchBar.leftView = leftView
        tempSearchBar.leftViewMode = .always
        
        tempSearchBar.backgroundColor = UIColor.white
        tempSearchBar.layer.cornerRadius = 4
        tempSearchBar.layer.borderColor = searchBarBorderColor.cgColor
        tempSearchBar.layer.borderWidth = 2
        
        tempSearchBar.layer.shadowColor = searchBarBorderColor.cgColor
        tempSearchBar.layer.shadowOpacity = 1
        tempSearchBar.layer.shadowOffset = CGSize.zero
        tempSearchBar.layer.shadowRadius = 4
        tempSearchBar.layer.shouldRasterize = true
        
        return tempSearchBar
    }
    
    func initialCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        
        let tempCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        tempCollectionView.dataSource = self
        tempCollectionView.delegate = self
        tempCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        tempCollectionView.backgroundColor = collectionViewBackgroundColor
        
        return tempCollectionView
    }
}

