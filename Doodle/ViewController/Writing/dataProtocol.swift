//
//  dataProtocol.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 7..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import UIKit

protocol sliderDelegate {
    func sliderValueData(data: CGFloat)
    func sliderValueData2(data: CGFloat)
}

protocol sliderAlphaDelegate {
    func sliderAlphaData(data: CGFloat)
}
