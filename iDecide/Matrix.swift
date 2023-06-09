//
//  Matrix.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI
import Firebase

struct Matrix: View {
    @State private var prosCons: [(proCon: String, score: Double)] = []
    @State private var newProCon: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State var newDecisionName: String = ""
    @State private var rank: Int = 1
    @State var changeView: Bool = false
    @ObservedObject var user: User
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack {
                Text("iDecide").font(.system(size: 64)).bold().foregroundColor(Color("DarkTeal"))
                    .padding()
                Text(newDecisionName).font(.system(size: 24)).bold()
                    .foregroundColor(Color("BurntRed"))
                    .padding()
                HStack {
                    TextField("New pro or con", text: $newProCon)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addProCon) {
                        Text("Add")
                            .foregroundColor(Color("DarkTeal"))
                    }
                }.padding()
                
                Divider()
                
                List {
                    ForEach(prosCons.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(prosCons[index].proCon)
                            HStack {
                                Text("Score: \(prosCons[index].score, specifier: "%.1f")")
                                    .foregroundColor(Color("DarkTeal"))
                                Slider(
                                    value: $prosCons[index].score,
                                    in: -10.0...10.0,
                                    step: 0.5,
                                    label: { EmptyView() }
                                )
                                .accentColor(color(forScore: prosCons[index].score))
                            }
                        }
                    }
                }
                
                Button(action: decide) {
                    Text("Decide")
                }
                .buttonStyle(SmallButton())
            }
            //        .alert(isPresented: $showAlert) {
            //            Alert(title: Text(alertMessage))
            //        }
            .alert("Verdict:", isPresented: $showAlert, actions: {
                Button(alertMessage, action: {changeView = true
                })
            })
            .navigationDestination(isPresented: $changeView) {
                PreviousDecisions(user: user)
            }
        }
    }
    
    func addProCon() {
        prosCons.append((proCon: newProCon, score: 0.0))
        newProCon = ""
    }
    
    func color(forScore score: Double) -> Color {
        let percentage = (score + 10) / 20
        return Color(
            red: 1 - percentage,
            green: percentage,
            blue: 0.0
        )
    }
    
    func decide() {
        let scores = prosCons.map { $0.score }
        let average = scores.reduce(0, +) / Double(prosCons.count)
        if average >= 1 {
            alertMessage = "Go for it!"
            rank = 5
        } else if average <= -1 {
            alertMessage = "No way!"
            rank = 1
        } else if average == 0 {
            alertMessage = "It's a coin toss!"
            rank = 3
        } else if average > -1 && average < 0 {
            alertMessage = "I have a bad feeling about this!"
            rank = 2
        } else if average > 0 && average < 1 {
            alertMessage = "Proceed with caution!"
            rank = 4
        }
        showAlert = true
        
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

/*struct Matrix_Previews: PreviewProvider {
    static var previews: some View {
        Matrix(decisions: Decisions())
    }
}*/
