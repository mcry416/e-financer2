//
//  HomeList.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation

class HomeList{
    public static func getLabelTitle(_ index: Int) -> String{
        switch index {
        case 0:
            return "随心e想1"
        case 1:
            return "随心e想2"
        case 2:
            return "随心e想3"
        case 3:
            return "随心e想4"
        case 4:
            return "随心e想5"
        case 5:
            return "随心e想6"
        case 6:
            return "随心e想7"
        case 7:
            return "随心e想8"
        case 8:
            return "随心e想9"
        case 9:
            return "随心e想10"
        default:
            return ""
        }
    }
    
    public static func getLabelContent(_ index: Int) -> String{
        switch index {
        case 0:
            return "本借贷方案适合当日亟需小额使用的社会中坚一代用户。标准日化：4.11‱"
        case 1:
            return "本借贷方案适合当日亟需大额使用的社会中坚一代用户。标准日化：5.12‱"
        case 2:
            return "本借贷方案适合当日亟需信用贷款的家庭中坚用户。月按揭：7.11%"
        case 3:
            return "本借贷方案适合当月亟需刚需生活使用的家庭中坚用户。月按揭：6.11%（月转化）"
        case 4:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        case 5:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        case 6:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        case 7:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        case 8:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        case 9:
            return "本借贷方案适合当月亟需资质重组的中小型科技企业。月按揭：10.61%"
        default:
            return ""
        }
    }
    
    public static func getService(_ index: Int) -> String{
        switch index {
        case 0:
            return "e1"
        case 1:
            return "e2"
        case 2:
            return "e3"
        case 3:
            return "e4"
        case 4:
            return "e5"
        case 5:
            return "e6"
        case 6:
            return "e7"
        case 7:
            return "e8"
        case 8:
            return "e9"
        case 9:
            return "e10"
        default:
            return ""
        }
    }
    
}
