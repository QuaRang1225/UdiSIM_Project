//
//  UserListView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct UserListView: View {
    
    @Environment(\.presentationMode) var presentMode
    @ObservedObject var vm = UserListViewModel()
    
    
    let user:UserData?
    init(user:UserData?){
        self.user = user
    }
    var body: some View {
        NavigationStack {
                ZStack(alignment:.top){
                    LinearGradient.udisimColor.ignoresSafeArea()
                    VStack(spacing:10){
                        CoverHeaderView(headerName: "친구목록"){
                            presentMode.wrappedValue.dismiss()
                        }
                        SearchBarView(text: $vm.searchText)
                        ScrollView{
                            ForEach(vm.searcheUser){ user in
                                LazyVStack{
                                    Divider()
                                        NavigationLink{
                                            ChatView(user: user)
                                        } label: {
                                            UserRowView(profileImage: URL(string: user.profileImageUrl), name: user.name,recent: user.email,time:Timestamp(),timeAction: false)
                                                .padding(.horizontal)
                                        }
                                }
                            }
                        }
                    }
                }
            
            
        }.navigationBarHidden(true)
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(user: UserData(email: "", name: "콰랑", password: "", profileImageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSayRz__4vNzLz2gzGEM12QerJaDANG8JTxng&usqp=CAU"))
    }
}

