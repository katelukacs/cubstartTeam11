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
            .frame(width: 300.0, height: 60.0)
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
    @Binding var userName: String
    @Binding var password: String
    
    var body: some View {
        //NavigationStack{
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
                        Text("LOG IN")
                    }
                    .navigationDestination(isPresented: $isPresenting) {
                        PreviousDecisions(decisions: Decisions())
                    }
                    .buttonStyle(BigButton())
                }
            }
        }
    }
//}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn(userName: .constant(""),password: .constant(""))
    }
}
