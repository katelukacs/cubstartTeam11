//
//  ContentView.swift
//  iDecide
//
//  Created by Kate Lukacs on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var navPath = NavigationPath()
    @State var changeView = false
    @State var isPresenting = false
    @State var isPresenting2 = false
    
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack {
                    Text("iDecide").font(.system(size: 64)).bold()
                        .foregroundColor(Color("DarkTeal"))
                        
//                    Text("...").font(.system(size: 64)).bold()
//                        .foregroundColor(Color("DarkTeal"))
                        
                    Button {
                        isPresenting = true
                    } label: {
                        Text("LOG IN")
                    }
                    .navigationDestination(isPresented: $isPresenting) {
                        LogIn()
                    }
                    .buttonStyle(BigButton())
                    Button {
                        isPresenting2 = true
                    } label: {
                        Text("SIGN UP")
                    }
                    .navigationDestination(isPresented: $isPresenting2) {
                        SignUp()
                    }
                    .buttonStyle(BigButton())
                }.navigationBarBackButtonHidden()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
