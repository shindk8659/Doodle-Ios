//
//  FilterView.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 7..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    let sliderThumbImage : UIImage? = UIImage(named: "thumb")
    var delegate: sliderAlphaDelegate?

    @IBOutlet var alphaSlider: UISlider!
    
    @IBOutlet var defaultImage: UIButton!
    @IBOutlet var defaultImg1: UIImageView!
    @IBOutlet var defaultImg2: UIImageView!
    @IBOutlet var defaultImg3: UIImageView!
    @IBOutlet var defaultImg4: UIImageView!
    @IBOutlet var defaultImg5: UIImageView!
    
    @IBOutlet var fogFilterBtn: UIButton!
    @IBOutlet var moonLightFilterBtn: UIButton!
    
    @IBOutlet var dawnFilterBtn: UIButton!
    @IBOutlet var latteFilterBtn: UIButton!
    @IBOutlet var sunsetFilterBtn: UIButton!
    
    
    
    
    
    @IBAction func alphaSlider(_ sender: UISlider) {
        let senderValue = CGFloat(sender.value)
        if delegate != nil{
            if senderValue != nil{
                delegate?.sliderAlphaData(data: senderValue)
            }
        }
    }
    
    func sliderThumbChange() {
        alphaSlider.setThumbImage(sliderThumbImage, for: .normal)
    }
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
