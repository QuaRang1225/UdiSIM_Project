//
//  Location.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/25.
//

import MapKit
import FirebaseFirestoreSwift

struct LocationData{
    
    static let location = "location"
    static let timestamp = "timestamp"
    static let sendId = "sendId"
    static let receiveId = "receiveId"
    static let name = "name"
    static let coordinateLong = "long"
    static let coordinateLat = "lat"
    static let email = "email"
    static let password = "password"
    static let profileImageUrl = "profileImageUrl"
    
}
struct Location:Codable,Identifiable{
    

    @DocumentID var id:String?
    
    let sendId,receiveId:String
    let coordinateLong,coordinateLat:Double
    
    var coordinate:CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude:CLongDouble(floatLiteral: coordinateLat), longitude: CLongDouble(floatLiteral: coordinateLong))
    }
//    enum LocationCodingKey:String,CodingKey{
//
//        case id =  "id"
//        case sendId =  "sendId"
//        case receiveId = "receiveId"
//        case coordinateLong = "coordinateLong"
//        case coordinateLat = "coordinateLat"
//    }
    init(id:String,data: [String:Any]) {
        self.id = id
        self.sendId = data[LocationData.sendId] as? String ?? ""
        self.receiveId = data[LocationData.receiveId] as? String ?? ""
        self.coordinateLong = data[LocationData.coordinateLong] as? Double ?? 0.0
        self.coordinateLat = data[LocationData.coordinateLat] as? Double ?? 0.0
    }
    
}

