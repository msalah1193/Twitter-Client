//
//  FollowersDelegates.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class FollowersTableDelegate: NSObject, UITableViewDelegate {
    
    //MARK:- Variables
    var listDelegate: ListViewsDelegate!
    
    init(listDelegate: ListViewsDelegate) {
        self.listDelegate = listDelegate
    }
    
    //MAKR:- Delegate Methods
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate.didSelectItemAt(index: indexPath.row)
    }
    
}

class CollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    //MARK:- Variables
    var cellSize: CGSize!
    var delegate: ListViewsDelegate!
    
    init(cellSize: CGSize, _ delegate: ListViewsDelegate) {
        super.init()
        self.cellSize = cellSize
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate.didSelectItemAt(index: indexPath.row)
        }
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if cellSize.width == 0 {
            return CGSize(width: collectionView.bounds.size.width,
                          height: cellSize.height)
        }
        
        return cellSize
    }
}
