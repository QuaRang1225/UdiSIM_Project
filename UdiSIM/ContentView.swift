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
        Group{
            ZStack{
                if logoAnimation{
                    if vm.userSession == nil{
                        LoginView()
                    }else{
                        MainView()
                    }
                }else{
                    StartView()
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }.environmentObject(AuthenticationViewModel())
    }
}
