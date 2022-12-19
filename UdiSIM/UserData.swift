//
//  UserData.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/19.
//


import Firebase
import FirebaseFirestoreSwift

struct UserData:Identifiable,Codable{   //데이터베이스 세팅과 같아야함 다르다면 코딩키 사용
    
    @DocumentID var id:String? //UUID().toString FireStore의 문서 ID 매핑가능
    let email:String
    let name:String
    let password:String
    var profileImageUrl:String
    

}
