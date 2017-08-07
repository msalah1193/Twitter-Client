//
//  CollectionDataSource.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/7/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import CSStickyHeaderFlowLayout

class CollectionDataSource<CellType: UICollectionViewCell, Model>: NSObject, UICollectionViewDataSource {
    
    //MARK:- Variables
    var cellIdentifier = ""
    var configureCell: (CellType, Model)->()!
    var configureHeader: (StickyHeaderCell)->()!
    var data: [Model]!
    
    required init(cellID: String, data: [Model], configureCell: @escaping (CellType, Model)->(), configureHeader: @escaping (StickyHeaderCell)->()) {
        self.cellIdentifier = cellID
        self.data = data
        self.configureCell = configureCell
        self.configureHeader = configureHeader
    }
    
    //MAKR:- Data Source Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CellType
        
        let model = data[indexPath.row]
        configureCell(cell, model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "StickyCell", for: indexPath) as! StickyHeaderCell
        
        configureHeader(cell)
        return cell
    }
}
