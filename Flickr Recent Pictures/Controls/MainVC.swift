//
//  ViewController.swift
//  Flickr Recent Pictures
//
//  Created by Emre Öner on 18.11.2019.
//  Copyright © 2019 Emre Öner. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var pageNumber = 1
    var photos = [Photo]()
    var isFetched = false
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            cv.backgroundColor = .systemBackground
        } else {
            cv.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        return cv
    }()
    
    let indicator: UIActivityIndicatorView = {
        let i = UIActivityIndicatorView()
        i.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            i.style = UIActivityIndicatorView.Style.large
        } else {
            i.style = UIActivityIndicatorView.Style.whiteLarge
        }
        i.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recent Photos"
        view.addSubview(collectionView)
        fetchRecentImages()
        self.collectionView.reloadData()
        NSLayoutConstraint.activate([collectionView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor), indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     indicator.widthAnchor.constraint(equalTo: view.widthAnchor), indicator.heightAnchor.constraint(equalTo: view.heightAnchor)])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func fetchRecentImages() {
        view.addSubview(indicator)
        indicator.startAnimating()
        API.instance.getRecentImages(pageNumber: pageNumber) { (tempPhotos) in
            self.photos += tempPhotos
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.removeFromSuperview()
                self.collectionView.reloadData()
            }
            
        }
        
    }

}

