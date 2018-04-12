//
//  EditView.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 6..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

class EditView: UIView {
    
    let sliderThumbImage : UIImage? = UIImage(named: "thumb")
    var delegate: sliderDelegate?
    
    @IBOutlet var textSizeSlider: UISlider!
    @IBOutlet var textLineSlider: UISlider!
    
    @IBOutlet var font1: UIButton!
    @IBOutlet var font2: UIButton!
    @IBOutlet var font3: UIButton!
    @IBOutlet var font4: UIButton!
    @IBOutlet var font5: UIButton!
    @IBOutlet var font6: UIButton!
    @IBOutlet var font7: UIButton!
    
    @IBOutlet var color1: UIButton!
    @IBOutlet var color2: UIButton!
    @IBOutlet var color3: UIButton!
    @IBOutlet var color4: UIButton!
    @IBOutlet var color5: UIButton!
    @IBOutlet var color6: UIButton!
    @IBOutlet var color7: UIButton!
    @IBOutlet var color8: UIButton!
    @IBOutlet var color9: UIButton!
    
    @IBAction func textSizeChange(_ sender: UISlider) {
            let senderValue = CGFloat(sender.value)
            if delegate != nil{
                if senderValue != nil{
                    delegate?.sliderValueData(data: senderValue)
                }
            }
        }
    
    
    @IBAction func textlineHeightChange(_ sender: UISlider) {
        let senderValue = CGFloat(sender.value)
        if delegate != nil {
              if senderValue != nil{
                delegate?.sliderValueData2(data: senderValue)
        }
    }
    }
    
    func sliderThumbChange() {
        textSizeSlider.setThumbImage(sliderThumbImage, for: .normal)
//        textSizeSlider.setThumbImage(sliderThumbImage, for: .highlighted)
        
        textLineSlider.setThumbImage(sliderThumbImage, for: .normal)
    }
    

}

