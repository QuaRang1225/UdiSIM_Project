//
//  MenuView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/19.
//

import SwiftUI
import Kingfisher

struct MenuView: View {
    
    @EnvironmentObject var vm:AuthenticationViewModel
    
    var body: some View {
//        if let user = vm.userdata{
//            VStack{
//                KFImage(URL(string: user.profileImageUrl))
//                    .resizable()
//                    .scaledToFill()
//                    .clipShape(Circle())
//                    .frame(width: 100,height: 100)
//                Text("d")
//            }
//        }
        VStack{
            Circle()
                .frame(width: 150,height: 150)
            Text("콰랑")
                .font(.largeTitle)
            Divider()
            HStack{
                Text("이메일")
                Text("quarang@gmail.com")
            }
            .padding()
            
//            NavigationLink {
//                <#code#>
//            } label: {
//                <#code#>
//            }

            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(AuthenticationViewModel())
    }
}
