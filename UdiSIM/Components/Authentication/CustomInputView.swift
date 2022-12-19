//
//  CustomInputView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct CustomInputView: View {
    let imageName:String
    let placeholderText:String
    var securefield:Bool? = false
    @Binding var text:String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundColor(.white)
                
                if securefield ?? false{
                    SecureField(placeholderText, text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                    
                }else{
                    TextField(placeholderText, text: $text)
                        .autocapitalization(.none)//첫글자 항상 소문자로 시작
                        .textCase(.lowercase)
                }
            }
            .foregroundColor(.white)
            Divider()
                .frame(height: 1)
                .background(Color.white)
            
        }.padding()
    }
}

struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
            CustomInputView(imageName: "envelope", placeholderText: "이메일", text: .constant(""))
        }.ignoresSafeArea()
    }
}

