//
//  UserRowView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/21.
//

import SwiftUI
import Kingfisher
import Firebase

struct UserRowView: View {
    let profileImage:URL?
    let name:String
    let recent:String?
    let time:Timestamp
    let timeAction:Bool
    
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = .init(identifier: "KOR")
        return calendar
    }()
    
    var body: some View {
        HStack(spacing: 10){
            KFImage(profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 30,height: 30)
                .clipShape(Circle())
            VStack(alignment: .leading){
                Text(name)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.white)
                Text(recent ?? "")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            if timeAction{
                Text("\(Date(timeIntervalSince1970: Double(time.seconds)), style: .relative) 전")
                    .environment(\.calendar, calendar)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            
        }
    }
}
struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            LinearGradient.udisimColor.ignoresSafeArea()
            UserRowView(profileImage:URL(string: "https:encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSayRz__4vNzLz2gzGEM12QerJaDANG8JTxng&usqp=CAU"), name: "콰랑", recent: "안뇽", time: Timestamp(),timeAction: false)
        }
        
    }
}
