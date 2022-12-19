//
//  UserListViewModel.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/21.
//

import Firebase
import FirebaseStorage

class UserListViewModel:ObservableObject{
    
    @Published var users:[UserData] = []
    @Published var searchText = ""
    let service = UserSerivce()
    
    init(){
        fetchUser()
    }
    
    var searcheUser:[UserData]{
        if searchText.isEmpty{
            return users
        }else{
            let query = searchText.lowercased()
            return users.filter{
                $0.name.contains(query) || $0.email.contains(query)
            }
        }
    }
    func fetchUser(){
        guard let myInfo = Auth.auth().currentUser?.email else{return}
        service.fetchUsers { users in
            self.users = users.filter {
                !$0.email.contains(myInfo)
            }
        }
    }
}
