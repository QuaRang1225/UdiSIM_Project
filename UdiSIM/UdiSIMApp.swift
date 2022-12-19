//
//  UdiSIMApp.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/19.
//

import SwiftUI
import Firebase

@main
struct UdiSIMApp: App {
    @StateObject var vm = AuthenticationViewModel()
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .environmentObject(vm)
            .environmentObject(ChatViewModel(user: vm.userdata))
        }
    }
}
