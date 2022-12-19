//
//  NavigationTitle.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/21.
//

import SwiftUI

extension View {
    
    @available(iOS 13, *)   //iOS버전 13부터
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ] //inline 모드
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]    //largeTitle 모드
        return self
    }
}
