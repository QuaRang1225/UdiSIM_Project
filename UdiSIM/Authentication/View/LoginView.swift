//
//  LoginView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct LoginView: View {
    @State var email:String = ""
    @State var password:String = ""
    @EnvironmentObject var vm:AuthenticationViewModel
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient.udisimColor.ignoresSafeArea()
                VStack(spacing:30){
                    AuthHeaderView(title: "로그인")
                        .padding(.bottom,150)
                    CustomInputView(imageName: "person", placeholderText: "이메일", text: $email)
                    CustomInputView(imageName: "lock", placeholderText: "비밀번호",securefield: true, text: $password)
                    login
                    Spacer()
                    regisetTransferButton
                }
                
                
            }.ignoresSafeArea()
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationViewModel())
    }
}
extension LoginView{
    var login:some View{
        Button {
            vm.login(email: email, password: password)
        } label: {
            LinearGradient.udisimColor.mask {
                Text("로그인")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(width: 350,height: 50)
            .background(Color.white)
            .clipShape(Capsule())
            .padding()
            
        }
    }
    var regisetTransferButton:some View{
        NavigationLink {
            RegisterView()
                .navigationBarHidden(true)
        } label: {
            HStack{
                Text("계정이 없으신가요?")
                    .font(.footnote)
                Text("회원가입")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            .padding(.bottom,30)
            .foregroundColor(.white)
        }
    }
}
