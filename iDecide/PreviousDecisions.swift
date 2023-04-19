//
//  PreviousDecisions.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI

struct PreviousDecisions: View {
    @State var changeView = false
    var body: some View {
        NavigationStack{
            VStack{
                Text("iDecide").font(.system(size: 64)).bold()
                Text("Previous Decisions").font(.system(size: 36)).bold()
                    .padding()
            }.foregroundColor(Color("DarkTeal"))
            VStack{
                Button {
                    changeView = true
                } label: {
                    Text("NEW DECISIONS")
                }
                .navigationDestination(isPresented: $changeView) {
                    Name()
                }
                .buttonStyle(BigButton())
            }
        }
    }
}

struct PreviousDecisions_Previews: PreviewProvider {
    static var previews: some View {
        PreviousDecisions()
    }
}
