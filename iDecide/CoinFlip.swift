//
//  CoinFlip.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI
import Firebase

struct CoinFlip: View {
    @State private var presentAlert = false
    @State private var presentAlert2 = false
    @State private var alertMessage: String = ""
    @State var faces: [String] = ["heads", "tails"]
    @State var face: String = "heads"
    @State var rotation: CGFloat = 0.0
    @State var offset_y: CGFloat = 0.0
    @State var coinBool: Bool = false
    @State var newDecisionName: String = ""
    @State var decisionBool: Bool = false
    @State var changeView: Bool = false
    @State var rank: Int = 1
    @ObservedObject var user: User
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Text("").font(.system(size: 32)).bold().foregroundColor(Color("DarkTeal"))
                    .alert("", isPresented: $presentAlert, actions: {
                        Button("heads", action: {
                            if coinBool { decisionBool = true
                            } else {
                                decisionBool = false
                            }
                        })
                        Button("tails", action: {
                            if coinBool { decisionBool = false
                            } else {
                                decisionBool = true
                            }
                        })
                    }, message: {
                        Text("call it in the air")
                    })
                    .alert("Verdict:", isPresented: $presentAlert2, actions: {
                        Button(alertMessage, action: {
                            changeView = true
                        })
                    })
                    .navigationDestination(isPresented: $changeView) {
                        PreviousDecisions(user: user)
                    }
                Text(face)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 150)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .rotation3DEffect(Angle(degrees: rotation), axis: (x: 1, y: 0, z: 0))
                    .offset(x: 0, y: offset_y)
                    .onTapGesture {
                        face = ""
                        coinBool = randomBool()
                        presentAlert = true
                        withAnimation(.linear(duration: 1)) {
                            rotation += 1080.0
                            offset_y = -300.0
                        }
                        
                        withAnimation(.linear(duration: 1).delay(1)) {
                            rotation += 1080.0
                            offset_y = 0.0
                        }
                        Task {
                            try await Task.sleep(nanoseconds: 1_900_000_000)
                            
                            if coinBool {
                                face = "heads"
                            } else {
                                face = "tails"
                            }
                            try await Task.sleep(nanoseconds: 900_000_000)
                            newDecision()
                            
                            if decisionBool {
                                alertMessage = "You should go for it"
                            }
                            else {
                                alertMessage = "This decision is a no-go"
                            
                            }
                            presentAlert2 = true
                        }
                    }
                //Text("decision = " + String(decisionBool))
            }
        }
    }
    func newDecision() {
        if decisionBool {
            rank = 5
        }
        else {
            rank = 1
        }
        
        let db = Firestore.firestore()
        db.collection("DecisionItem").addDocument(data: [
            "name": newDecisionName,
            "decide": rank,
            "user": user.id
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                user.fetchDecisions()
                print("Document successfully written!")
            }
        }
    }
}


/*struct CoinFlip_Previews: PreviewProvider {
    static var previews: some View {
        CoinFlip(decisions: Decisions())
    }
}*/
