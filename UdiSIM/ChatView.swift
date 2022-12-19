//
//  ChatView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/22.
//

import SwiftUI
import MapKit
import Firebase


struct ChatView: View {
    
    let user:UserData?
    
    init(user: UserData?) {
        self.user = user
        self.vmChat = .init(user: user)
    }
    
    @StateObject private var vm = MapViewModel()
    @ObservedObject var vmChat:ChatViewModel
    @Environment(\.presentationMode) var presentMode
    
    
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .top){
                LinearGradient.udisimColor.ignoresSafeArea()
                VStack(spacing:20){
                    CoverHeaderView(headerName: user!.name) {
                        presentMode.wrappedValue.dismiss()
                    }
                    ZStack(alignment: .bottom) {
                        map
                        locationButton
                        GpsButton {
                            vm.cheackLocation()
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user:  UserData(email: "", name: "콰랑", password: "", profileImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSayRz__4vNzLz2gzGEM12QerJaDANG8JTxng&usqp=CAU"))
        
    }
}
extension ChatView{
    
    var map:some View{
        Map(coordinateRegion:Binding(get: {
            vm.mapRegion
        }, set: { newValue, _ in
            vm.mapRegion = newValue
        }), showsUserLocation: true, annotationItems: vmChat.location) { item in
            MapAnnotation(coordinate: item.coordinate){
                if item.sendId == Auth.auth().currentUser?.uid {
                    Image("pinkman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .shadow(color: .white, radius: 20)
                }
                else{
                    Image("blueman")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .shadow(color: .white, radius: 20)
                }
            }
        }
       .ignoresSafeArea()
        
    }
    var locationButton:some View{
        Button {
            vmChat.newChat(vm: vm)
            
        } label: {
            Image("pinkman")
                .resizable()
                .scaledToFill()
                .frame(width: 150,height: 150)
                .shadow(radius: 20)
        }
    }
}
