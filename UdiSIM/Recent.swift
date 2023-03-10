//
//  Recent.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/12/12.
//

import Firebase
import FirebaseFirestoreSwift

struct Recent:Codable,Identifiable{
    
    @DocumentID var id:String? = UUID().uuidString
    
    let sendId,receiveId:String
    let location,name:String
    let profileImageUrl:String
    let timestamp:Timestamp
    
    init(id:String,data: [String:Any]) {
        self.id = id
        self.sendId = data[LocationData.sendId] as? String ?? ""
        self.receiveId = data[LocationData.receiveId] as? String ?? ""
        self.location = data[LocationData.location] as? String ?? ""
        self.name = data[LocationData.name] as? String ?? ""
        self.profileImageUrl = data[LocationData.profileImageUrl] as? String ?? ""
        self.timestamp = data[LocationData.timestamp] as? Timestamp ?? Timestamp()
    }

}
