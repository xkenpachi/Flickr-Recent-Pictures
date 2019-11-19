//
//  MainVC+Extensions.swift
//  Flickr Recent Pictures
//
//  Created by Emre Öner on 18.11.2019.
//  Copyright © 2019 Emre Öner. All rights reserved.
//

import UIKit

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        cell.configCell(photo: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.photo = photos[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if yOffset > contentHeight - scrollView.frame.height * 2 {
            if !isFetched {
                addMoreImage()
            }
        }
    }
    
    func addMoreImage() {
        view.addSubview(indicator)
        indicator.startAnimating()
        isFetched = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.pageNumber += 1
            API.instance.getRecentImages(pageNumber: self.pageNumber) { (tempPhotos) in
                self.photos += tempPhotos
                self.isFetched = false
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.indicator.removeFromSuperview()
                    self.collectionView.reloadData()
                }
                
            }
        }
    }
    
}
