//
//  SuggestViewController.swift
//  
//
//  Created by 乃方 on 2018/9/27.
//

import UIKit

class SuggestViewController: UIViewController {

    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var showCollectionView: UICollectionView!
    
    var fullScreenSize: CGSize!
    var articleImage = [UIImage]()
    var photoWidth: CGFloat!
    
    var cuisine = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fullScreenSize = UIScreen.main.bounds.size
        typeCollectionSet()
        
        let nib2 = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        showCollectionView.register(nib2, forCellWithReuseIdentifier: "ProfileBCell")
        
//        let layout2 = UICollectionViewFlowLayout()
//        layout2.sectionInset = UIEdgeInsets(top: 7.5, left: 5, bottom: 7.5, right: 5)
//        layout2.minimumInteritemSpacing = 7.5
//        layout2.minimumLineSpacing = 7.5
        
//        photoWidth = CGFloat(fullScreenSize.width) / 3 - 10
//        layout2.itemSize = CGSize(width: photoWidth, height: photoWidth)
//        showCollectionView.collectionViewLayout = layout2
        
        articleImage = [UIImage(named: "01"), UIImage(named: "02"),
                        UIImage(named: "03"), UIImage(named: "04"),
                        UIImage(named: "05"), UIImage(named: "06"),
                        UIImage(named: "07"), UIImage(named: "08"),
                        UIImage(named: "09"), UIImage(named: "10"),
                        UIImage(named: "01"), UIImage(named: "02"),
                        UIImage(named: "03"), UIImage(named: "04"),
                        UIImage(named: "05"), UIImage(named: "06"),
                        UIImage(named: "07"), UIImage(named: "08")] as! [UIImage]
        
        cuisine = ["中式料理","日式料理","美式料理","義式料理","韓式料理",
                   "中式料理","日式料理","美式料理","義式料理","韓式料理"]
        
        showCollectionView.delegate = self
        showCollectionView.dataSource = self
        
//        self.showCollectionView!.collectionViewLayout = circularLayoutObject

        
    }
    
    func typeCollectionSet() {
     
        let nib = UINib(nibName: "TypeCollectionViewCell", bundle: nil)
        typeCollectionView.register(nib, forCellWithReuseIdentifier: "TypeCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: (self.view.frame.size.width - 30) / 2, height: 80)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 10)
        layout.scrollDirection = .horizontal
        typeCollectionView.collectionViewLayout = layout
        typeCollectionView.showsHorizontalScrollIndicator = false
        
        typeCollectionView.dataSource = self
        typeCollectionView.delegate = self
    }
    
}

extension SuggestViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.typeCollectionView {
            
            return 10
            
        } else {
            
            return 18
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.typeCollectionView {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCell", for: indexPath) as? TypeCollectionViewCell else {
                
                return UICollectionViewCell()
                
            }
            
            cell.typeLabel.text = cuisine[indexPath.item]
            cell.typeImage.image = articleImage[indexPath.item]
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileBCell", for: indexPath) as? ProfileCollectionViewCell else {
                
                return UICollectionViewCell()
                
            }
            
            cell.articleImage.image = articleImage[indexPath.item]
            
            return cell
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.item)
        
    }
    
}

extension SuggestViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        if collectionView == self.showCollectionView {

            if indexPath.item % 6 == 0 {

//                let cellWidth = (fullScreenSize.width / 3) - 7.5
//
//                print(cellWidth)
//
//                return CGSize(width: cellWidth, height: cellWidth)
//
//            } else if indexPath.item % 6 == 1 {
//
//                let cellWidth = (fullScreenSize.width / 3) - 7.5
//
//                return CGSize(width: cellWidth, height: cellWidth)
//
//            } else if indexPath.item % 6 == 2 {
//
//                let cellWidth = (fullScreenSize.width / 3) - 7.5
//
//                return CGSize(width: cellWidth, height: cellWidth)
//
//            } else if indexPath.item % 6 == 3 {
//
//                let cellWidth = ((fullScreenSize.width / 3) - 10) * 2 + 15
//
//                return CGSize(width: cellWidth, height: cellWidth)
//
//            } else if indexPath.item % 6 == 4 {
//
//                let cellWidth = (fullScreenSize.width / 3) - 7.5
//
//                return CGSize(width: cellWidth, height: cellWidth)
//
//            } else if indexPath.item % 6 == 5 {
//
                let cellWidth = (fullScreenSize.width / 3) - 7.5

                return CGSize(width: cellWidth, height: cellWidth)

            }
            
        }

        return CGSize(width: (self.view.frame.size.width - 30) / 2, height: 80)
    }

}

//    let cellWidth = (collectionView.bounds.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right) - flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsPerLine - 1)) / CGFloat(numberOfCellsPerLine)
//
//    return CGSize(width: cellWidth, height: cellWidth)
//
//}
//
//// layout.itemSize = CGSize(width: (self.view.frame.size.width - 30) / 2, height: 80)
//return CGSize(width: (self.view.frame.size.width - 30) / 2, height: 80)
