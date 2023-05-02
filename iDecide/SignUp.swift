//
//  SignUp.swift
//  iDecide
//
//  Created by Kate Lukacs on 24/04/23.
//

import SwiftUI
import Firebase

struct SignUp: View {
    @State var isPresenting = false
    @State var isPresenting2 = false
    @State var email = ""
    @State var password = ""
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            self.isPresenting = true
        }
    }
    
    var body: some View {
        //NavigationStack{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                VStack{
                    Spacer()
                    
                    Text("iDecide").font(.system(size: 64)).bold().foregroundColor(Color("DarkTeal"))
                    VStack(spacing:0){
                        TextField("Email", text: $email)
                            .font(.system(size: 20))
                            .padding()
                            .frame(width: 300.0, height: 60.0)
                            .background(Color("Grey"))
                            .roundedCorner(20, corners: [.topLeft, .topRight])
                            .textInputAutocapitalization(.never)
                        Divider()
                            .frame(width:300.0)
                            .background(.black)
                        SecureField("Password", text: $password)
                            .font(.system(size: 20))
                            .padding()
                            .frame(width: 300.0, height: 60.0)
                            .background(Color("Grey"))
                            .roundedCorner(20, corners: [.bottomRight, .bottomLeft])
                            .textInputAutocapitalization(.never)
                        
                        
                    }.padding()
                    
                    Button {
                        isPresenting = true
                        createUser(email: email, password: password)
                    } label: {
                        Text("SIGN UP")
                    }
                    .buttonStyle(BigButton())
                    Spacer()
                    HStack {
                        Text("Have an account?")
                        Button("Log In") {
                            isPresenting2 = true
                        }
                        .foregroundColor(Color.black)
                        .bold()
                    }
                }
                .navigationDestination(isPresented: $isPresenting) {
                    Name(decisionName: "")
                }
                .navigationDestination(isPresented: $isPresenting2) {
                    LogIn()
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
//}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
