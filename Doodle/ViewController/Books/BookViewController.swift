//
//  BookViewController.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 13..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class BookViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    // CollectionView variable:
    //    var collectionView : UICollectionView?
    @IBOutlet var collectionView: UICollectionView!
//    var count : Int = 0
//    let book1 = Book1ViewController()
//    let book2 = Book2ViewController()
    
    // Variables asociated to collection view:
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    fileprivate var colors: [UIImage] = [UIImage(named: "book_bigbook1")!, UIImage(named: "book_bigbook2")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        
        self.addCollectionView()
        self.setupLayout()
        
    }
    
    func setupLayout(){
        // This is just an utility custom class to calculate screen points
        // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        self.collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: pointEstimator.relativeHeight(multiplier: 0.1754)).isActive = true
        self.collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView?.heightAnchor.constraint(equalToConstant: pointEstimator.relativeHeight(multiplier: 0.6887)).isActive = true
        
        self.currentPage = 0
    }
    
    
    func addCollectionView(){
        
        // This is just an utility custom class to calculate screen points
        // to the screen based in a reference view. You can ignore this and write the points manually where is required.
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        // This is where the magic is done. With the flow layout the views are set to make costum movements. See https://github.com/ink-spot/UPCarouselFlowLayout for more info
        let layout = UPCarouselFlowLayout()
        // This is used for setting the cell size (size of each view in this case)
        // Here I'm writting 400 points of height and the 73.33% of the height view frame in points.
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.73333), height: 400)
        // Setting the scroll direction
        layout.scrollDirection = .horizontal
        
        // Collection view initialization, the collectionView must be
        // initialized with a layout object.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // This line if for able programmatic constrains.
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        // CollectionView delegates and dataSource:
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        // Registering the class for the collection view cells
        self.collectionView?.register(CardCell.self, forCellWithReuseIdentifier: "cellId")
        
        // Spacing between cells:
        let spacingLayout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)
        
        self.collectionView?.backgroundColor = UIColor.clear
        self.view.addSubview(self.collectionView!)
        
    }
    
    // MARK: - Card Collection Delegate & DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CardCell
        
        //        cell.customView.backgroundColor = colors[indexPath.row]
        //        cell.customView.imageView?.image = colors[indexPath.row]
        cell.customView.image = colors[indexPath.row]
        //        cell.customView.setImage(colors[indexPath.row], for: .normal)
        //        cell.customView.addTarget(self, action: #selector(bookClicked), for: UIControlEvents.touchUpInside)
//        if indexPath.row == 0 {
//            count = 1
//        }
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.showsHorizontalScrollIndicator = false
        let layout = self.collectionView?.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    //    @objc func bookClicked(_ sender: AnyObject?) {
    //        if count == 1 {
    //            self.navigationController?.pushViewController(book1, animated: false)
    //            print(count)
    //        } else {
    //            self.navigationController?.pushViewController(book2, animated: false)
    //            print(count)
    //        }
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath == [0, 0] {
            performSegue(withIdentifier: "book1", sender: nil)
            print(indexPath)
        } else if indexPath == [0, 1] {
            performSegue(withIdentifier: "book2", sender: nil)
            print(indexPath)
        }
    }
}

class CardCell: UICollectionViewCell {
    let customView: UIImageView = {
        //        let view = UIView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.layer.cornerRadius = 12
        //        return view
        //        let view = UIButton()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.layer.cornerRadius = 12
        //        return view
        
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.customView)
        
        self.customView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.customView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.customView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.customView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
} // End of CardCell

class RelativeLayoutUtilityClass {
    
    var heightFrame: CGFloat?
    var widthFrame: CGFloat?
    
    init(referenceFrameSize: CGSize){
        heightFrame = referenceFrameSize.height
        widthFrame = referenceFrameSize.width
    }
    
    func relativeHeight(multiplier: CGFloat) -> CGFloat{
        
        return multiplier * self.heightFrame!
    }
    
    func relativeWidth(multiplier: CGFloat) -> CGFloat{
        return multiplier * self.widthFrame!
        
    }
}



