//
//  DetailVC.swift
//  Flickr Recent Pictures
//
//  Created by Emre Öner on 18.11.2019.
//  Copyright © 2019 Emre Öner. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
   let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var photo: Photo!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(imageView)
        title = photo.title
        NSLayoutConstraint.activate([imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     imageView.heightAnchor.constraint(equalTo: view.heightAnchor)])
         let imageURL = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg"
        imageView.cachedImages(urlString: imageURL)
    }
    


}
