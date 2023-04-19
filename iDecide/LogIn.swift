//
//  LogIn.swift
//  iDecide
//
//  Created by Steven Guo on 4/17/23.
//

import SwiftUI
struct BigButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .font(.system(size: 20))
            .padding()
            .frame(width: 310.0, height: 60.0)
            .background(Color("DarkTeal"))
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20,style:.continuous))
    }
}

struct SmallButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.bold)
            .font(.system(size: 20))
            .padding()
            .frame(width: 150.0, height: 60.0)
            .background(Color("DarkTeal"))
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20,style:.continuous))
    }
}

struct LogIn: View {
    @State var isPresenting = false

    var body: some View {
        NavigationStack{
            VStack{
                Text("iDecide").font(.system(size: 64)).bold().foregroundColor(Color("DarkTeal"))
                Text("Username holder")
                    .padding()
                Text("Password holder")
                    .padding()
                
                Button {
                    isPresenting = true
                } label: {
                    Text("LOG IN")
                }
                .navigationDestination(isPresented: $isPresenting) {
                    PreviousDecisions()
                }
                .buttonStyle(BigButton())
            }
            
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
