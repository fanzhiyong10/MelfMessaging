//
//  ConfigureOfColor.swift
//  M-Elf
//
//  Created by 范志勇 on 2019/8/2.
//  Copyright © 2019 范志勇. All rights reserved.
//

import UIKit

class ConfigureOfColor {
    // apple颜色
    static let grayColor = UIColor(red: 142.0/255, green: 142.0/255, blue: 147.0/255, alpha: 1.0)
    static let blueColor = UIColor(red: 0.0, green: 122.0/255, blue: 255/255, alpha: 1.0)
    static let greenColor = UIColor(red: 52.0/255, green: 199.0/255, blue: 89.0/255, alpha: 1.0)
    static let indigoColor = UIColor(red: 88.0/255, green: 86.0/255, blue: 214.0/255, alpha: 1.0)
    static let redColor = UIColor(red: 255/255, green: 59.0/255, blue: 48.0/255, alpha: 1.0)
    static let yellowColor = UIColor(red: 255.0/255, green: 204.0/255, blue: 0.0/255, alpha: 1.0)
    static let orangeColor = UIColor(red: 255.0/255, green: 149.0/255, blue: 0.0/255, alpha: 1.0)
    static let pinkColor = UIColor(red: 255.0/255, green: 45.0/255, blue: 85.0/255, alpha: 1.0)
    static let tealColor = UIColor(red: 90.0/255, green: 200.0/255, blue: 250.0/255, alpha: 1.0)
    static let purpleColor = UIColor(red: 175.0/255, green: 82.0/255, blue: 222.0/255, alpha: 1.0)

    // ======= 列表
    // 四色
    static let alpha4: CGFloat = 0.4
    static let row41BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD9)/255, blue: CGFloat(0xB6)/255, alpha: alpha4) // FFD9B6
    static let row42BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xFA)/255, blue: CGFloat(0xCE)/255, alpha: alpha4) // FFFACE
    static let row43BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xCB)/255, green: CGFloat(0xF2)/255, blue: CGFloat(0xDC)/255, alpha: alpha4) // CBF2DC
    static let row44BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xFA)/255, blue: CGFloat(0xCE)/255, alpha: alpha4) // FFFACE
    
//    static let row41BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0x93)/255, blue: CGFloat(0x00)/255, alpha: 0.08) // FF9300
//    static let row42BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD5)/255, blue: CGFloat(0x4A)/255, alpha: 0.08) // FFD54A
//    static let row43BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0xAF)/255, blue: CGFloat(0xE5)/255, alpha: 0.08) // 00AFE5
//    static let row44BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD5)/255, blue: CGFloat(0x4A)/255, alpha: 0.08) // FFD54A

    
    // 三色：1
    static let row1BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0x93)/255, blue: CGFloat(0x00)/255, alpha: 0.08) // FF9300
    // 三色：2
    static let row2BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD5)/255, blue: CGFloat(0x4A)/255, alpha: 0.08) // FFD54A
    // 三色：3
    static let row3BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0xAF)/255, blue: CGFloat(0xE5)/255, alpha: 0.08) // 00AFE5
//    static let row1BackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xE4)/255, green: CGFloat(0x43)/255, blue: CGFloat(0x85)/255, alpha: 0.05) // E44385

    // ======= 列表
    // 奇数行，背景色
    static let oddRowBackgroundColor = UIColor(red: CGFloat(0.8), green: CGFloat(1.0), blue: CGFloat(0.4), alpha: CGFloat(0.1))
    // 偶数行，背景色
    static let evenRowBackgroundColor = UIColor(red: CGFloat(1.0), green: CGFloat(0.8), blue: CGFloat(0.4), alpha: CGFloat(0.1))
    
    // 奇数行，背景色：EBF9FD
    static let oddRowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xF0)/255, green: CGFloat(0xFB)/255, blue: CGFloat(0xFE)/255, alpha: 1.0) // F0FBFE
    // 偶数行，背景色：FFF7EB
    static let evenRowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xF7)/255, blue: CGFloat(0xEB)/255, alpha: 1.0)
    
    // 行内有2种背景色：区分上下
    static let evenRowAboveBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xF7)/255, blue: CGFloat(0xEB)/255, alpha: 1.0) // FFF7EB
    static let evenRowBelowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xEF)/255, blue: CGFloat(0xD9)/255, alpha: 1.0) // FFEFD9
    static let oddRowAboveBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xEB)/255, green: CGFloat(0xF9)/255, blue: CGFloat(0xFD)/255, alpha: 1.0) // EBF9FD
    static let oddRowBelowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xD9)/255, green: CGFloat(0xF3)/255, blue: CGFloat(0xFB)/255, alpha: 1.0) // D9F3FB

    
    // section：黄色0.3
//    static let sectionBackgroundColor = UIColor(red: 255.0/255, green: 204.0/255, blue: 0.0/255, alpha: 0.3)
//    static let sectionBackgroundColor = UIColor(red: 255.0/255, green: 239.0/255, blue: 177.0/255, alpha: 1.0) // 不透明
    
    // ======= 表格：section
    static let sectionBackgroundColor = UIColor(red: 255.0/255, green: 228.0/255, blue: 191.0/255, alpha: 1.0) // orangeColor，0.25，不透明
    
    // 版本2：FFDEB2、00AFE5
    // 列表，section，仅一种色背景色
    static let sectionBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xDE)/255, blue: CGFloat(0xB2)/255, alpha: 1.0) // FFDEB2
    // 列表，section，字体前景色
    static let sectionTextColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0xAF)/255, blue: CGFloat(0xE5)/255, alpha: 1.0) // 00AFE5
    
    // 列表，section，奇偶不同色
    static let sectionEvenBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xDE)/255, blue: CGFloat(0xB2)/255, alpha: 1.0) // FFDEB2
    static let sectionEvenTextColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0x93)/255, blue: CGFloat(0x00)/255, alpha: 1.0) // FF9300
    static let sectionOddBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xBF)/255, green: CGFloat(0xEB)/255, blue: CGFloat(0xF8)/255, alpha: 1.0) // BFEBF8
    static let sectionOddTextColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0xAF)/255, blue: CGFloat(0xE5)/255, alpha: 1.0) // 00AFE5

    // 选择变色：FFE180
    static let selectBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xE1)/255, blue: CGFloat(0x80)/255, alpha: 1.0)

    
    // 表格：section，偶数
    static let evenSectionBackgroundColor = UIColor(red: 255.0/255, green: 228.0/255, blue: 191.0/255, alpha: 1.0) // orangeColor，0.25，不透明
    // 表格：section，奇数
    static let oddSectionBackgroundColor = UIColor(red: 206.0/255, green: 241.0/255, blue: 213.0/255, alpha: 1.0) // greenColor，0.25，不透明
    
    // 沙漏上的文字颜色
    static let deviationLabelColorOnAboveZero = UIColor.red // 沙漏上方
    static let deviationLabelColorOnBelowZero = UIColor.red // 沙漏下方
    static let deviationLabelColorOnZero = UIColor.darkGray
    
    // ==== 打分窗口
    static let scoreBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xEA)/255, blue: CGFloat(0xA4)/255, alpha: 1.0) // FFEAA4
    static let scoreTextColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0x26)/255, blue: CGFloat(0x00)/255, alpha: 1.0) // FF2600
    static let scoreCatologTextColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0x00)/255, blue: CGFloat(0x00)/255, alpha: 1.0) // 000000
    static let continueBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0x00)/255, green: CGFloat(0xAF)/255, blue: CGFloat(0xE5)/255, alpha: 1.0) // 00AFE5
    static let continueTextColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xFF)/255, blue: CGFloat(0xFF)/255, alpha: 1.0) // FFFFFF
    static let reviewBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD5)/255, blue: CGFloat(0x4A)/255, alpha: 1.0) // FFD54A
    static let reviewTextColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0x26)/255, blue: CGFloat(0x00)/255, alpha: 1.0) // FF2600
    
    // ==== 速度窗口
//    static let tempoAboveBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xDE)/255, blue: CGFloat(0xB2)/255, alpha: 1.0) // FFDEB2
//    static let tempoBelowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xEF)/255, blue: CGFloat(0xD9)/255, alpha: 1.0) // FFEFD9
    
//    static let tempoAboveBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xD5)/255, blue: CGFloat(0x9D)/255, alpha: 1.0) // FFD59D
//    static let tempoBelowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xFF)/255, green: CGFloat(0xE2)/255, blue: CGFloat(0xBC)/255, alpha: 1.0) // FFE2BC
    
    static let tempoAboveBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xF9)/255, green: CGFloat(0xF9)/255, blue: CGFloat(0xF9)/255, alpha: 1.0)

    static let tempoBelowBackgroundColorV2 = UIColor(displayP3Red: CGFloat(0xCC)/255, green: CGFloat(0xCC)/255, blue: CGFloat(0xCC)/255, alpha: 1.0)
    /*
    static var tempoAboveBackgroundColorV2: UIColor {
        var hue : CGFloat = 0.0
        var saturation : CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        orangeColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let color = UIColor(hue: hue, saturation: saturation*0.7, brightness: 1.2, alpha: alpha)
        return color
    }
    */
    /*
    static var tempoBelowBackgroundColorV2: UIColor {
        var hue : CGFloat = 0.0
        var saturation : CGFloat = 0.0
        var brightness : CGFloat = 0.0
        var alpha : CGFloat = 0.0
        orangeColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let color = UIColor(hue: hue, saturation: saturation*1.0, brightness: 1.2, alpha: alpha)//0.85, 1.2
        return color
    }
    */
    
    // ==== 各个音符的评分页面
    // ---- 各个音符
    static let backgroundColorOfReview  = UIColor(displayP3Red: 1.0, green: 1.0, blue: 0.0, alpha: 0.5)
    // 负值：00A10C
    static let negativeScorefontColorOfReview  = UIColor(displayP3Red: CGFloat(0x00)/255.0, green: CGFloat(0xA1)/255.0, blue: CGFloat(0x0C)/255.0, alpha: 1.0)
    // 正值：红
    static let positiveScorefontColorOfReview  = UIColor.red
    // 零值：灰
    static let zeroScorefontColorOfReview  = UIColor.darkGray

    // 导航栏，背景色
    static let navigatorbar_backgroundColor  = UIColor(displayP3Red: 242.0/255, green: 242.0/255, blue: 247.0/255, alpha: 1.0)
    
    // 视唱模式
    static let backgroundColorOfSightsingingMode  = blueColor.withAlphaComponent(0.5)
    static let colorolorOfSightsingingMode  = UIColor.yellow
    // 演奏模式
    static let backgroundColorOfPlayingMode  = blueColor.withAlphaComponent(0.5)
    static let colorolorOfPlayingMode  = UIColor.yellow
}
