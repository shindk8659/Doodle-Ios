//
//  SaveListCollectionViewCell.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 10..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class SaveListCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var nicknameLabel: UIButton!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postListImg: UIImageView!
    
   
    @IBOutlet var gongGam: UIButton!
    @IBOutlet var comment: UIButton!
    @IBOutlet var scrap: UIButton!
    
    @IBAction func nicknameBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var EditBtn: UIButton!
    
}

