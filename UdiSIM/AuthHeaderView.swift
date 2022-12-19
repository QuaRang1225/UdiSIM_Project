//
//  AuthHeaderView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct AuthHeaderView: View {
    let title:String
    var body: some View {
        VStack{
            LinearGradient.udisimColor
        }
        .mask(
            HStack{
                Text(title)
                    .font(Font.system(size: 46, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top,50)
                Spacer()
            }
        )
        .padding()
        .frame(width: UIScreen.main.bounds.width,height: 200)
        .background(Color.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
        .shadow(radius: 20)
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            AuthHeaderView(title: "제목")
        }.ignoresSafeArea()
    }
}
