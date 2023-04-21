//
//  CoinFlip.swift
//  iDecide
//
//  Created by Kate Lukacs on 18/04/23.
//

import SwiftUI

struct CoinFlip: View {
    @State private var presentAlert = false
    @State var faces: [String] = ["heads", "tails"]
    @State var face: String = "heads"
    @State var rotation: CGFloat = 0.0
    @State var offset_y: CGFloat = 0.0
    @State var decision: Bool = false
    @State var coinBool: Bool = false
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    var body: some View {
        VStack {
            Text("").font(.system(size: 32)).bold().foregroundColor(Color("DarkTeal"))
                .alert("", isPresented: $presentAlert, actions: {
                    Button("heads", action: {
                        if face == "heads" { decision = true
                        } else {
                            decision = false
                        }
                    })
                    Button("tails", action: {
                        if face == "tails" { decision = true
                        } else {
                            decision = false
                        }
                    })
                }, message: {
                    Text("call it in the air")
                })
            Text(face)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: 150, height: 150)
                .background(Color.brown)
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
                }
            }
            Text("decision = " + String(decision))
        }
    }
}

struct CoinFlip_Previews: PreviewProvider {
    static var previews: some View {
        CoinFlip()
    }
}
