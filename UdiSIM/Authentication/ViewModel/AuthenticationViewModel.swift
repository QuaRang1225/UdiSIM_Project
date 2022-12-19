//
//  AuthenticationViewModel.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI
import Firebase

class AuthenticationViewModel:ObservableObject{
    
    @Published var userSession:FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    func register(email:String,name:String,password:String){
        Auth.auth().createUser(withEmail: email, password: password){ result, error   in
            if let error = error {
                print("회원가입 실패 \(error)")
                return
            }
            //guard let user = result?.user else{ return }    //유저정보가 비어있다면 반환
             //유저 로그인 정보 로그인 여부에 전달
            print("회원가입 성공")
        }
    }
    func login(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error {
                print("로그인 실패 \(error)")
                return
            }
            guard let user = result?.user else{ return }    //유저정보가 비어있다면 반환
            self.userSession = user
            print("로그인 성공")
        }
    }
    func logout(){
        userSession = nil
        try? Auth.auth().signOut()
    }
}
