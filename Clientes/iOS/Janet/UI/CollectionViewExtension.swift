//
//  CollectionViewExtension.swift
//  [TFG] Asistente virtual para servicios de la biblioteca de la UCM - Codename "Janet"
//
//  Created by Mauri on 11/11/18.
//  Copyright © 2018 Mauricio Abbati Loureiro - Jose Luis Moreno Varillas. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mensajes.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        //cell.layer.cornerRadius = 10
        
        cell.setMessage(info: mensajes[indexPath.row])
        
        //if (mensajes.count == 1) {
            
            if (mensajes[indexPath.row].getEmisor() == .User) {
                cell.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
            } else {
                cell.contentView.transform = CGAffineTransform(scaleX: 1,y: 1);
            }
        
        
        let numberOfCellsPerRow: CGFloat = 1
        
        if (mensajes.count == 0) {
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
                let cellWidth = ((view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow)
                
                //print (flowLayout.itemSize.height)
                flowLayout.itemSize = CGSize(width: cellWidth, height: cell.getAltura() + 15)
                //print (flowLayout.itemSize.height)
            }
        } /*else {
            if let bubble = self.collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    //let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                    //print(bubble.getText())
                    let horizontalSpacing = (flowLayout.scrollDirection == .vertical) ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
                    let cellWidth = ((view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing)/numberOfCellsPerRow)
                    flowLayout.itemSize = CGSize(width: cellWidth, height: bubble.getAltura() + 15)
                    return bubble
                }
            }
        }*/
        //cell.updateAltura()
        //collectionView.cellForItem(at: <#T##IndexPath#>).layou
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (mensajes.count != 1) {
            var result: CGSize = CGSize(width: 300, height: 100)
            
            if let bubble = self.collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                
                if (mensajes[indexPath.row].getEmisor() == .User) {
                    bubble.contentView.transform = CGAffineTransform(scaleX: -1,y: 1);
                } else {
                    bubble.contentView.transform = CGAffineTransform(scaleX: 1,y: 1);
                }
                
                let numberOfCellsPerRow: CGFloat = 1
                
                let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
                //print(bubble.getText())
                let horizontalSpacing = (flowLayout?.scrollDirection == .vertical) ? flowLayout?.minimumInteritemSpacing : flowLayout?.minimumLineSpacing
                let cellWidth = ((view.frame.width - max(0, numberOfCellsPerRow - 1)*horizontalSpacing!)/numberOfCellsPerRow)
                result = CGSize(width: cellWidth, height: bubble.getAltura() + 15)
                
            }
            return result
        }
        else {
            return collectionView.frame.size
        }
    }
    
    internal func lastIndexPath() -> IndexPath? {
        for sectionIndex in (0..<collectionView.numberOfSections).reversed() {
            if collectionView.numberOfItems(inSection: sectionIndex) > 0 {
                return IndexPath.init(item: collectionView.numberOfItems(inSection: sectionIndex)-1, section: sectionIndex)
            }
        }
        
        return nil
    }
    
}
