//
//  Matrix.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI

struct Matrix: View {
    @ObservedObject var decisions: Decisions
    @State private var prosCons: [(proCon: String, score: Double)] = []
    @State private var newProCon: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State var newDecisionName: String = ""
    @State private var rank: Int = 1
    @State var changeView: Bool = false
    
    var body: some View {
        VStack {
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
        .alert("", isPresented: $showAlert, actions: {
            Button(alertMessage, action: {changeView = true
            })
        })
        .navigationDestination(isPresented: $changeView) {
            PreviousDecisions(decisions: decisions)
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
        let item = DecisionItem(name: newDecisionName, decide: rank)
        decisions.items.append(item)
    }
}

struct Matrix_Previews: PreviewProvider {
    static var previews: some View {
        Matrix(decisions: Decisions())
    }
}
