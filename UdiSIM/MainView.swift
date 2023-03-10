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
    
    
    @State var newChat = false
    @State var remove = false
    
    let service = UserSerivce()
    
    @EnvironmentObject var vm:AuthenticationViewModel
    

    
    var body: some View {
        NavigationStack{
            
                ZStack{
                    if let user = vm.userdata{
                    LinearGradient.udisimColor.ignoresSafeArea()
                    VStack{
                        userHeader(user: user)
                            .onAppear{
                                print("지금 유저 \(user)")
                            }
                        List{
                            ForEach(vm.recent){ item in
                                NavigationLink {
                                    ChatView(user: UserData(id:item.receiveId,email: "", name: item.name, password: "", profileImageUrl: item.profileImageUrl))
                                } label: {
                                    UserRowView(profileImage: URL(string: item.profileImageUrl) , name: item.name, recent: item.location, time: item.timestamp,timeAction: true)
                                }
                            }
                            .onDelete(perform: removeRow)
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        
                    }
                    newChatView
                        
                   
                }else{
                    Button {
                        vm.userSession = nil
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            

        }.foregroundColor(.white)
    }
    func removeRow(at offsets: IndexSet){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        for off in offsets{
            Firestore.firestore()
                .collection("recent")
                .document(uid)
                .collection("message")
                .document(vm.recent[off].receiveId)
                .delete()
        }
        vm.isRemove = false
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
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
                    vm.isLogOut.toggle()
                }){
                    Image(systemName: "door.left.hand.open")
                }.alert(isPresented : $vm.isLogOut){
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
