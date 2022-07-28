//
//  HomeView.swift
//  Rerupa
//
//  Created by Balqis on 21/07/22.
//

import SwiftUI
import PencilKit

struct HomeView: View {
    
    //ML
    @StateObject private var model = ContentViewModel()
    @State private var showContours = false
    @State private var showSettings = false
    
    //imagepicker
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    
    @State var toolPicker = PKToolPicker()
    @State var pencilKitCanvasView = PKCanvasView()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rerupa")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding()
            
            Spacer()
            
            VStack {
                Text("After upload the picture, click Show Canvas")
                HStack {
                    Button("Choose Picture") {
                        self.showSheet = true
                    }
                    .frame(width: 150, height: 30)
                    .background(.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .font(.system(size: 15, weight: .semibold))
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
                    
                    Button("Show Canvas") {
                        model.startContour()
                        self.showContours.toggle()
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
                }
                
                ZStack {
                    PencilKitView(toolPicker: $toolPicker, pencilKitCanvasView: $pencilKitCanvasView)
                    if showContours {
                        ContoursView(contours: model.contours)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 800, height: 800, alignment: .topLeading)
                            .clipped()
                            .padding()
                    } else {
                        Image(uiImage: model.uiImage ?? UIImage(named: "rectangle")!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 800, height: 800, alignment: .topLeading)
                            .clipped()
                            .padding()
                    }
                }
                .background()
                
                
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$model.uiImage, isShown: self.$showImagePicker, sourceType: self.sourceType)
            }
            
            .navigationViewStyle(StackNavigationViewStyle())
        }
        }
        
    
}

struct PencilKitView: UIViewRepresentable {
    
    @Binding var toolPicker: PKToolPicker
    @Binding var pencilKitCanvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        pencilKitCanvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        
        toolPicker.addObserver(pencilKitCanvasView)
        
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        
        pencilKitCanvasView.becomeFirstResponder()
        
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
