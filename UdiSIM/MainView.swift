//
//  MainView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/21.
//

import SwiftUI
import Firebase
import Kingfisher

struct MainView: View {
    @State var logOut = false
    @State var newChat = false
    let service = UserSerivce()
    
    @EnvironmentObject var vm:AuthenticationViewModel
    
    var body: some View {
        if let user = vm.userdata{
            NavigationStack{
                ZStack{
                    LinearGradient.udisimColor.ignoresSafeArea()
                    VStack{
                        userHeader(user: user)
                        ScrollView{
                                ForEach(vm.recent){ item in
                                    LazyVStack{
                                        Divider()
                                        NavigationLink {
                                            ChatView(user: UserData(id:item.receiveId,email: "", name: item.name, password: "", profileImageUrl: item.profileImageUrl))
                                        } label: {
                                            UserRowView(profileImage: URL(string: item.profileImageUrl) , name: item.name, recent: item.location, time: item.timestamp,timeAction: true)
                                        }
                                    }
                                    .padding(.leading)
                                }
                        }
                    }
                    newChatView
                }
            }.foregroundColor(.white)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }.environmentObject(AuthenticationViewModel())
    }
}

extension MainView{
    
    func userHeader(user:UserData) -> some View{
        VStack(alignment:.leading){
            HStack(spacing: 0){
                KFImage(URL(string:user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50,height: 50)
                    .clipShape(Circle())
                    .padding(.trailing)
                VStack(alignment: .leading,spacing: 0){
                    Text(user.name)
                        .bold()
                        .font(.title)
                    Text(user.email)
                        .font(.caption)
                    
                }
                Spacer()
                Button(action: {
                    logOut.toggle()
                }){
                    Image(systemName: "door.left.hand.open")
                }.alert(isPresented : $logOut){
                    Alert(title: Text("로그아웃을 하시겠습니까?"),message: Text("로그아웃을 할 경우 로그인 화면으로 바로 넘어가게 됩니다."), primaryButton: .destructive(Text("로그아웃"),action: {
                        vm.logOut()
                    }), secondaryButton: .cancel(Text("취소")))
                }
            }
            .padding(.horizontal)
        }
        
    }
    var newChatView:some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button {
                    newChat.toggle()
                } label: {
                    Image(systemName: "plus.message.fill")
                        .resizable()
                        .frame(width: 80,height: 80)
                        .edgesIgnoringSafeArea(.all)
                        .padding(.trailing)
                }
                .fullScreenCover(isPresented: $newChat) {
                    UserListView(user: vm.userdata)
                }
            }
        }
    }
}
