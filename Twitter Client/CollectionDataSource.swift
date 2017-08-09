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
    private var cellIdentifier = ""
    private var configureCell: (CellType, Model)->()!
    private var data: [Model]!
    
    var configureHeader: ((StickyHeaderCell)->())? = nil
    
    required init(cellID: String, data: [Model], configureCell: @escaping (CellType, Model)->()) {
        self.cellIdentifier = cellID
        self.data = data
        self.configureCell = configureCell
    }
    
    
    //MARK:- Data Source Methods
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
        
        guard let configHeader = configureHeader else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: "StickyCell", for: indexPath) as! StickyHeaderCell
        
        configHeader(cell)
        return cell
    }
    
}
