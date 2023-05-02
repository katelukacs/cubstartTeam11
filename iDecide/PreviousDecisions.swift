//
//  PreviousDecisions.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI
import Firebase

struct PreviousDecisions: View {
    @State var changeView = false
    @State var isLoggedOut = false
    @ObservedObject var decisions : Decisions
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedOut = true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    var body: some View {
        //NavigationStack{
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button("Log Out") {
                        logOut()
                    }.bold().padding()
                }
                
                Text("iDecide").font(.system(size: 64)).bold()
                Text("Previous Decisions").font(.system(size: 36)).bold()
                    .padding()
                
                if (!decisions.items.isEmpty) {
                    List {
                        ForEach(decisions.items, id: \.id){item in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.name)
                                    Spacer()
                                    if item.decide == 5 {
                                        Text("✅✅")
                                    }
                                    else if item.decide == 4 {
                                        Text("✅")
                                    }
                                    else if item.decide == 3 {
                                        Text("🤷‍♀️")
                                    }
                                    else if item.decide == 2 {
                                        Text("❌")
                                    }
                                    else if item.decide == 1 {
                                        Text("❌❌")
                                    }
                                }
                            }
                        }
                    }
                    .background(Color("Background")).scrollContentBackground(.hidden)
                }
                else {
                    Spacer()
                }
                
                Button {
                    changeView = true
                } label: {
                    Text("NEW DECISION")
                }
                .buttonStyle(BigButton())
            }
            .foregroundColor(Color("DarkTeal"))
            .navigationDestination(isPresented: $changeView) {
                Name(decisionName: "", decisions: decisions)
            }
            .navigationDestination(isPresented: $isLoggedOut) {
                ContentView()
            }
            .navigationBarBackButtonHidden()
        }
    }
}
//}

struct PreviousDecisions_Previews: PreviewProvider {
    static var previews: some View {
        PreviousDecisions(decisions: Decisions())
    }
}
