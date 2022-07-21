//
//  ContentView.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = ContentViewModel()
    @State private var showContours = false
    @State private var showSettings = false
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                if showContours {
                  ContoursView(contours: model.contours)
                } else {
                  ImageView(image: model.image)
                }
                
                VStack {
                    Spacer()
                    Text("Rerupa")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(uiImage: image ?? UIImage(named: "rectangle")!)
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Spacer()
                    
                    Button("Choose Picture") {
                        self.showSheet = true
                    }
                    .frame(width: 200, height: 50)
                    .background(
                        LinearGradient(colors: [
                        Color("purple"),
                        Color("pink")
                        ], startPoint: .bottom, endPoint: .top))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 20, weight: .bold))
                    .padding()
                        .actionSheet(isPresented: $showSheet) {
                            ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                                .default(Text("Photo Library")) {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                },
                                .default(Text("Camera")) {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                },
                                .cancel()
                            ])
                    }
                    Spacer(minLength: 150)
                }
            }
            .onTapGesture {
              self.showContours.toggle()
            }
            
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
