//
//  UserService.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/19.
//

import Firebase
import FirebaseFirestoreSwift


struct UserSerivce{
    func fetchUser(uid:String,completion: @escaping (UserData) -> Void){      //유저정보 업데이트 -> 로그인 후에 로그인 상태를 유지하기 위한
        Firestore.firestore().collection("user")
            .document(uid)      //유저 아이디의 있는 내용
            .getDocument { snapshot, _ in           //유저 데이터 불러옴
                guard let snapshot = snapshot else{return}
                guard let user = try? snapshot.data(as: UserData.self) else {return}    //데이터베이스에 있는내용 디코딩하여 저장
                completion(user)
            }
    }
    func fetchUsers(completion: @escaping ([UserData]) -> Void){      //모든 유저정보 업데이트
        Firestore.firestore().collection("user")
            .getDocuments{ snapshot, _ in   //모든 유저 데이터 불러옴
                guard let document = snapshot?.documents else{return}   //옵셔널 체이닝
                let users = document.compactMap {   // 배열에 nil을 제거하여 출력할 대 사용 map -> 배열의 내용을 필터링하여 출력하기 위함
                    try? $0.data(as:UserData.self)
                }
                completion(users)
            }
    }

}
