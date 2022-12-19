//
//  SearchBarView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text:String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray.opacity(0.5))
            TextField("친구 검색..", text: $text)
                
        }
        .padding()
        .background(Color.white.opacity(0.5))
        .cornerRadius(10)
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""))
    }
}
