//
//  MapViewModel.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/22.
//

import SwiftUI
import MapKit
import CoreLocation


final class MapViewModel:NSObject,CLLocationManagerDelegate,ObservableObject{
    
    private var manager = CLLocationManager()
    var mySpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    @Published var mapRegion = MKCoordinateRegion()
    @Published var mapCoordinate = CLLocationCoordinate2D()
    
    override init() {
        super.init()
        manager.delegate = self
    }
 
    func cheackLocation(){
        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled(){
                self.manager = CLLocationManager()
                self.manager.delegate = self
            }else{
                print("지도가 꺼져있음")
            }
        }
    }
    func cheackLocationAuthrization(){
        switch manager.authorizationStatus{
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .restricted:
            print("위치정보 제한")
        case .denied:
            print("위치정보 거부")
        case .authorizedAlways, .authorizedWhenInUse:
                withAnimation(.easeOut){
                        self.mapCoordinate = self.manager.location!.coordinate
                        self.mapRegion = MKCoordinateRegion(center: self.mapCoordinate, span: self.mySpan)
                }
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.cheackLocationAuthrization()
        
    }
    
}



