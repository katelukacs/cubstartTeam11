//
//  SignUp.swift
//  iDecide
//
//  Created by Kate Lukacs on 24/04/23.
//

import SwiftUI

struct SignUp: View {
    @State var isPresenting = false
    @Binding var userName: String
    @Binding var password: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                VStack{
                    Text("iDecide").font(.system(size: 64)).bold().foregroundColor(Color("DarkTeal"))
                    VStack(spacing:0){
                        TextField("Username", text: $userName)
                            .font(.system(size: 20))
                            .padding()
                            .frame(width: 300.0, height: 60.0)
                            .background(Color("Grey"))
                            .roundedCorner(20, corners: [.topLeft, .topRight])
                        Divider()
                            .frame(width:300.0)
                            .background(.black)
                        TextField("Password", text: $password)
                            .font(.system(size: 20))
                            .padding()
                            .frame(width: 300.0, height: 60.0)
                            .background(Color("Grey"))
                            .roundedCorner(20, corners: [.bottomRight, .bottomLeft])
                        
                        
                    }.padding()
                    
                    Button {
                        isPresenting = true
                    } label: {
                        Text("SIGN UP")
                    }
                    .navigationDestination(isPresented: $isPresenting) {
                        Name()
                    }
                    .buttonStyle(BigButton())
                }
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(userName: .constant(""),password: .constant(""))
    }
}
