//
//  PhotoPicker.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI
import PhotosUI

class PhotoPicker:ObservableObject{
    @Published var selectItem:[PhotosPickerItem] = []   //사진 피커 화면
    @Published var selectPhotoItem:[Data] = []  //실제 저장 사진
    

    func selectPhoto(item:[PhotosPickerItem]) {
        DispatchQueue.main.async {
            self.selectPhotoItem.removeAll()
            Task {  //사진 저장 동기처러
                for newItem in item {
                    //Task - 비동기
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        self.selectPhotoItem.append(data)
                    }
                }
            }
        }
        
    }
}
