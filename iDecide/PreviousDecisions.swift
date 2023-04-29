//
//  PreviousDecisions.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI

struct PreviousDecisions: View {
    @State var changeView = false
    @ObservedObject var decisions : Decisions
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("iDecide").font(.system(size: 64)).bold()
                Text("Previous Decisions").font(.system(size: 36)).bold()
                    .padding()
            }.foregroundColor(Color("DarkTeal"))
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
            VStack{
                Button {
                    changeView = true
                } label: {
                    Text("NEW DECISION")
                }
                .navigationDestination(isPresented: $changeView) {
                    Name(decisionName: "", decisions: decisions)
                }
                .buttonStyle(BigButton())
            }
        }
    }
}

struct PreviousDecisions_Previews: PreviewProvider {
    static var previews: some View {
        PreviousDecisions(decisions: Decisions())
    }
}
