//
//  TestAnimaion.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct TestAnimaion: View {
    
    
    @State var arr:[String] = []
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))

    @State var annotations:[Location] = [
//           Location(coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
           
       ]
    
    var body: some View {
        ZStack{
            LinearGradient.udisimColor.ignoresSafeArea()
            Map(coordinateRegion: $region, annotationItems: annotations) {
                       MapPin(coordinate: $0.coordinate)
                   }
                   .frame(width: 400, height: 300)
            VStack{
                Button {
//                    arr.append("안녕")
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                        withAnimation(.easeInOut(duration: 1.0)){
//                            return arr.removeFirst()
//                        }
//                    }
                    annotations.append( Location(coordinate: CLLocationCoordinate2D(latitude: 52.507222, longitude: -0.1275)))
                } label: {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                VStack{
                    ForEach(arr, id: \.self) {
                        Text("\($0)")
                    }
                }
                
                
                //                if actionView{
                //                    Text("오잉")
                //                        .onAppear{
                //                            DispatchQueue.global().async{
                //                                withAnimation(.easeInOut(duration: 5)){
                //                                    actionView = false
                //                                }
                //                            }
                //                        }
                //                }
            }
        }
        
        
        
    }
    
}

struct TestAnimaion_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimaion()
    }
}
