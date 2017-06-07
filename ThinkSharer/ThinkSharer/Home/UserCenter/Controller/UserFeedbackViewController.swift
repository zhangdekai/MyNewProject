//
//  UserFeedbackViewController.swift
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/7.
//  Copyright © 2017年 张德凯. All rights reserved.
//

import UIKit

class UserFeedbackViewController: BasicViewController {

    var photos = [UIImage]()
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.backgroundGrayColorA()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UserFeedbackCollectionViewCell.self, forCellWithReuseIdentifier: "UserFeedbackCollectionViewCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilizeUI()
    }
    
    func initilizeUI() {
        self.setNavigationBarBack()
        self.setNavigationBarTitle("信息反馈")
        self.setNavigationBarRightItemWithTitle("提交") {
            print("提交")
        }
        self.view.addSubview(collectionView)
        
    }

    override func selectedPhoto(_ photos: [Any]!) {
        self.photos = photos as! [UIImage]
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension UserFeedbackViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.isEmpty {
            return 1
        }
        if photos.count == 3 {
            return 3
        }
        return photos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedbackCollectionViewCell", for: indexPath)as!UserFeedbackCollectionViewCell
        if indexPath.row == photos.count {
            cell.deleteImageView.isHidden = true
            cell.icon.isHidden = false
            cell.addPhotoLabel.isHidden = false
            cell.selectedImageView.image = nil
        } else {
            cell.selectedImageView.image = photos[indexPath.row]
            cell.deleteImageView.isHidden = false
            cell.icon.isHidden = true
            cell.addPhotoLabel.isHidden = true

        }
        
        cell.deletePhotosBlock = {[weak self] in
            guard let `self` = self else {
                return
            }
            
            self.photos.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.row == photos.count {
                self.selectPhoto()
            }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenWidth - CGFloat(60).scalValue) / 3, height: CGFloat(112.5).scalValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, CGFloat(15).scalValue, 0, CGFloat(15).scalValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15).scalValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0).scalValue
    }

}
