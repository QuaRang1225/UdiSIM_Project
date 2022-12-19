//
//  ContentView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI

struct ContentView: View {
    @State var logoAnimation = false
    @EnvironmentObject var vm:AuthenticationViewModel
    var body: some View {
        NavigationView{
            VStack {
                if logoAnimation{
                    if vm.userSession == nil{
                        LoginView()
                    }else{
                        Button {
                            vm.logout()
                        } label: {
                            Text("로그아웃")
                        }

                    }
                }else{
                    StartView()
                }
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeOut(duration: 0.5)){
                        logoAnimation = true
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
