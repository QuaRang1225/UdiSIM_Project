//
//  RegisterView.swift
//  UdiSIM
//
//  Created by 유영웅 on 2022/11/18.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct RegisterView: View {
    @State var isRegister = false
    @State var email:String = ""
    @State var name:String = ""
    @State var password:String = ""
    @State var passwordConfirm:String = ""
    @Environment(\.presentationMode) var presentMode
    @StateObject var photo = PhotoPicker()
    @EnvironmentObject var vm:AuthenticationViewModel
    var body: some View {
        
        ZStack{
            LinearGradient.udisimColor.ignoresSafeArea()
            
            VStack(spacing:20){
                AuthHeaderView(title: "회원가입")
                selectImage
                Group{
                    CustomInputView(imageName: "person", placeholderText: "이메일", text: $email)
                    CustomInputView(imageName: "person.fill", placeholderText: "이름", text: $name)
                    CustomInputView(imageName: "lock", placeholderText: "비밀번호",securefield: true, text: $password)
                    CustomInputView(imageName: "lock.fill", placeholderText: "비밀번호 확인",securefield: true, text: $passwordConfirm)
                }
                register
                Spacer()
                loginTransferButton
            }
            
            
        }.ignoresSafeArea()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
extension RegisterView{
    var register:some View{
        Button {
            if password == passwordConfirm{
                vm.register(email: email, name: name, password: password)
            }else{
                self.isRegister.toggle()
            }
        } label: {
            LinearGradient.udisimColor
                .mask {
                    Text("회원가입")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(width: 350,height: 50)
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
            
        }.alert(isPresented: $isRegister) {
            Alert(title: Text("비밀번호가 일치하지않습니다!"),dismissButton: .default(Text("확인")))
        }
    }
    var loginTransferButton:some View{
        Button {
            presentMode.wrappedValue.dismiss()
        } label: {
            HStack{
                Text("계정이 이미 있으신가요?")
                    .font(.footnote)
                Text("로그인")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            
        }
        .padding(.bottom,30)
        .foregroundColor(.white)
    }
    var selectImage:some View{
        PhotosPicker(selection: $photo.selectItem, maxSelectionCount: 1, matching: .images){
            if photo.selectPhotoItem.isEmpty{
                ZStack{
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .modifier(imageModifier())
                    Circle()
                        .stroke(Color.white)
                        .frame(width: 150,height: 150)
                }
            }
            else{
                ForEach(photo.selectPhotoItem,id: \.self){
                    if let image = UIImage(data: $0){
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .modifier(imageModifier())
                    }
                }
            }
        }.onChange(of: photo.selectItem,perform: photo.selectPhoto)
    }
    private struct imageModifier:ViewModifier{
        func body(content: Content) -> some View {
            content
                .frame(width: 150,height: 150)
                .padding()
        }
    }
}
