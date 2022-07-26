//
//  ContentView.swift
//  Rerupa
//
//  Created by Balqis on 19/07/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var isPresenting = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Rerupa")
                        .font(.system(size: 40))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                    
                    Button {
                        isPresenting = true
                    } label: {
                        Text("Start")
                            .frame(width: 200, height: 70)
                            .background(.white)
                            .foregroundColor(Color("pink"))
                            .cornerRadius(30)
                            .font(.title)
                        
                        NavigationLink(destination: HomeView()
                            .navigationBarBackButtonHidden(true), isActive: $isPresenting) {
                                EmptyView()
                            }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
