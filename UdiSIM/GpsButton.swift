//
//  GpsButton.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/25.
//

import SwiftUI
import CoreLocationUI

struct GpsButton: View {
    let action:()->()
    var body: some View {
        HStack{
            Spacer()
            LocationButton(.currentLocation){
               action()
            }
            .labelStyle(.iconOnly)
            .foregroundColor(.pink)
            .symbolVariant(.fill)
            .tint(.white)
            .cornerRadius(10)
            .shadow(radius: 20)
            .padding(.trailing,20)
        }
    }
}

struct GpsButton_Previews: PreviewProvider {
    static var previews: some View {
        GpsButton(action: {})
    }
}
