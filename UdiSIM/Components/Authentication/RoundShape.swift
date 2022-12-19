//
//  RoundShape.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct RoundedShape:Shape{
    var corners:UIRectCorner    //직사각형 모서리값
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 50, height: 100))
        //직사각형 코너와 사이즈등 규격 기재
        return Path(path.cgPath)
        //세팅된 직사각형 규격을 경로로 보내서 주문제작
    }
}
