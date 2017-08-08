//
//  StickyHeaderCell.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/7/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class StickyHeaderCell: UICollectionViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    
    //MARK:- Variables
    var delegate: StickyHeaderCellDelegate!
    
    //MARK:- Gestures
    func setupTapGestures() {
        //add tap gesture recognizer to profile image
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewProfile.isUserInteractionEnabled = true
        imageViewProfile.addGestureRecognizer(profileTapGesture)
        
        //add tap gesture recognizer to background image
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewBackground.isUserInteractionEnabled = true
        imageViewBackground.addGestureRecognizer(backgroundTapGesture)
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let cellDelegate = delegate else {
           return
        }
        
        guard let tappedImage = tapGestureRecognizer.view as? UIImageView else {
            return
        }
        
        cellDelegate.didTapImage(image: tappedImage.image!)
    }
}
