//
//  ContentView.swift
//  iDecide
//
//  Created by Kate Lukacs on 17/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack {
                    Text("iDecide").font(.system(size: 64)).bold()
                    Text("...").font(.system(size: 64)).bold()
                }.foregroundColor(Color("DarkTeal"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
