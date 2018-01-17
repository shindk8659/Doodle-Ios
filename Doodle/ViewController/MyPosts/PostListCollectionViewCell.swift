//
//  PostListCollectionViewCell.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 9..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class PostListCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        
    }
    
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postListImg: UIImageView!
    
    @IBOutlet var gongGam: UIButton!
    @IBOutlet var comment: UIButton!
    @IBOutlet var scrap: UIButton!
    
  
    @IBOutlet weak var EditBtn: UIButton!
    
   
    
}


