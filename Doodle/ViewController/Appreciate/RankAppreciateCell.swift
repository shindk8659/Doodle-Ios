//
//  RankAppreciateCell.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class RankAppreciateCell: UITableViewCell {
    
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var reportBtn: UIButton!
    @IBOutlet var appreciateImage: UIImageView!
    @IBOutlet var gongGam: UIButton!
    @IBOutlet var comment: UIButton!
    @IBOutlet var scrap: UIButton!
    @IBOutlet var thisNickname: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
