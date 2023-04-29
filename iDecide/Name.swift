//
//  Name.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//


import SwiftUI

struct Name: View {
    @State private var presentAlert = false
    @State var decisionName: String
    @State var changeView = false
    @State var changeView2 = false
    @StateObject var decisions = Decisions()


    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background").ignoresSafeArea()
            
                VStack{
                    Text("iDecide").font(.system(size: 64)).bold().foregroundColor(Color("DarkTeal"))
                        .padding()
                    Text("Let's help you decide:").font(.system(size:30))
                        .foregroundColor(Color("BurntRed"))
                        .padding()
                    Divider()
                    Text(decisionName).font(.system(size:30))
                        .foregroundColor(Color("BurntRed"))
                        .padding()
                    Divider()
                    
                    
                    Text("Choose your path").font(.system(size: 32)).bold().foregroundColor(Color("DarkTeal"))
                        .alert("Decision Name", isPresented: $presentAlert, actions: {
                            TextField("Rescue a pup?", text: $decisionName)
                            Button("OK", action: {})
                        }, message: {
                            Text("What's on your mind?")
                        })

                    
                    HStack{
                        Button {
                            changeView = true
                        } label: {
                            Text("COIN FLIP")
                        }
                        .navigationDestination(isPresented: $changeView) {
                            
                            CoinFlip(decisions: decisions, newDecisionName: decisionName)
                        }
                        .buttonStyle(SmallButton())
                        
                        Button {
                            changeView2 = true
                        } label: {
                            Text("MATRIX")
                        }
                        .navigationDestination(isPresented: $changeView2) {
                            Matrix(decisions: decisions, newDecisionName: decisionName)
                        }
                        .buttonStyle(SmallButton())
                    }
                }
            }.onAppear{
                presentAlert = true
                
            }
        }
    }
}

struct Name_Previews: PreviewProvider {
    static var previews: some View {
        Name(decisionName: "")
    }
}
