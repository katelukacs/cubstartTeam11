//
//  LogIn.swift
//  iDecide
//
//  Created by Steven Guo on 4/17/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

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
    @State var isPresenting2 = false
    @State var email = ""
    @State var password = ""
    @StateObject var user = User(id: "")
    
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            let id = result?.user.uid
            user.id = id ?? ""
            user.fetchDecisions()

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
                        login(email: email, password: password)
                    } label: {
                        Text("LOG IN")
                    }
                    .buttonStyle(BigButton())
                    
                    Spacer()
                    
                    HStack {
                        Text("Don't have an account?")
                        Button("Sign Up") {
                            isPresenting2 = true
                        }
                        .foregroundColor(Color.black)
                        .bold()
                    }
                }
                .navigationDestination(isPresented: $isPresenting) {
                    PreviousDecisions(user: self.user)
                }
                .navigationDestination(isPresented: $isPresenting2) {
                    SignUp(user: user)
                }
                .navigationBarBackButtonHidden()
            }
        }
    }
//}

/*struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}*/
