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
    var feedContent = ""
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.backgroundGrayColorA()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UserFeedbackCollectionViewCell.self, forCellWithReuseIdentifier: "UserFeedbackCollectionViewCell")
        collectionView.register(UserFeedbackContentCell.self, forCellWithReuseIdentifier: "UserFeedbackContentCell")

        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilizeUI()
    }
    
    
    func initilizeUI() {
        self.setNavigationBarBack()
        self.setNavigationBarTitle("信息反馈")
        
        self.setNavigationBarRightItemWithTitle("提交") {[weak self] in
            guard let `self` = self else {return}
            
            print("提交",self.feedContent)
        }
        self.view.addSubview(collectionView)
        
    }

    override func selectedPhoto(_ photos: [Any]!) {
        self.photos = photos as! [UIImage]
        collectionView.reloadData()
    }
    
    override func takedPhoto(_ photo: UIImage!) {
        self.photos.append(photo)
        collectionView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension UserFeedbackViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if photos.isEmpty {
                return 1
            }
            if photos.count == 3 {
                return 3
            }
            return photos.count + 1
        } else {
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
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
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserFeedbackContentCell", for: indexPath)as!UserFeedbackContentCell
            cell.feedbackTextView.delegate = self
            
            return cell
        }
        
    }
    
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == photos.count {
                self.view.endEditing(true)
                self.selectPhoto()
            }
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (ScreenWidth - CGFloat(60).scalValue) / 3, height: CGFloat(112.5).scalValue)

        } else {
            return CGSize(width: ScreenWidth, height: 175)

        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsetsMake(0, CGFloat(15).scalValue, 0, CGFloat(15).scalValue)

        } else {
            return UIEdgeInsetsMake(0, 0, 0, 0)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15).scalValue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0).scalValue
    }
    //MARK: UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        feedContent = textView.text
    }
    

}
