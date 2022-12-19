//
//  ChatViewModel.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/25.
//

import Firebase
import FirebaseStorage
import CoreLocation

class ChatViewModel:ObservableObject{
    
    @Published var location:[Location] = []
    
    private var tempUserSession:FirebaseAuth.User?
    let user:UserData?
    var myLoc:String?
    
    init(user:UserData?){
        self.user = user
        fetchChat()
    }

    func fetchChat(){
        
        guard let sendId = Auth.auth().currentUser?.uid else{return}
        guard let receiveId = user?.id  else{return}
        
        
        
        Firestore.firestore()
            .collection("location")
            .document(sendId)
            .collection(receiveId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error{
                    print("에러메세지 : \(error.localizedDescription)")
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added{
                        self.location.removeAll()
                        let data = change.document.data()
                        self.location.append(.init(id: change.document.documentID,data: data))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            self.location.removeAll()
                        }
                    }
                })
                
            }
        
    }
   
    func newChat(vm:MapViewModel){
       
        
        guard let sendId = Auth.auth().currentUser?.uid else{return}
        guard let receiveId = user?.id  else{return}
        
        recentLocation(vm: vm)

        
        let sendDocument =
        Firestore.firestore().collection("location")
            .document(sendId)
            .collection(receiveId)
            .document()
        
        let receiveDocument =
        Firestore.firestore().collection("location")
            .document(receiveId)
            .collection(sendId)
            .document()
        
        let locationData = [ LocationData.sendId:sendId,LocationData.receiveId:receiveId,LocationData.coordinateLat:vm.mapCoordinate.latitude,LocationData.coordinateLong:vm.mapCoordinate.longitude,"timestamp":Timestamp()] as [String : Any]
        
        sendDocument.setData(locationData) { error in
            if let error = error{
                print("서버에 데이터전송이 실패하였습니다. \(error.localizedDescription)")
            }
            self.recentMessage()
        }
        receiveDocument.setData(locationData) { error in
            if let error = error{
                print("서버에 데이터전송이 실패하였습니다. \(error.localizedDescription)")
            }
        }
        
        
    }
    private func recentMessage(){
        
        
        guard let uid = Auth.auth().currentUser?.uid else{return}
        guard let chatuser = user else {return}
        guard let myLoc = myLoc else {return}
        guard let receiveId = user?.id  else{return}
        
        let document = Firestore.firestore().collection("recent")
            .document(uid)
            .collection("message")
            .document(receiveId)
        
        let data = [
            LocationData.timestamp:Timestamp(),
            LocationData.location:myLoc,
            LocationData.sendId:uid,
            LocationData.receiveId:receiveId,
            LocationData.profileImageUrl:chatuser.profileImageUrl,
            LocationData.name:chatuser.name
        ] as [String:Any]
        
        document.setData(data) { error in
            if let error = error{
                print("최근 메세지를 받아올 수 없습니다. \(error.localizedDescription)")
            }
        }
    }
    
    func recentLocation(vm:MapViewModel){
        let findLocation = CLLocation(latitude: vm.mapCoordinate.latitude, longitude: vm.mapCoordinate.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name:String = address.last?.name {
                    self.myLoc = name
                }
            }
        })
    }
    
    
}
