//
//  CoverHeaderView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/25.
//

import SwiftUI

struct CoverHeaderView: View {
    
    let headerName:String
    let active:()->()
    
    var body: some View {
        ZStack{
            Text(headerName)
                .bold()
                .foregroundColor(.white)
            HStack{
                Button{
                    active()
                }label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                }.padding(.horizontal)
                Spacer()
                
            }
        }
    }
}

struct CoverHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CoverHeaderView(headerName: "제목",active: {})
    }
}
