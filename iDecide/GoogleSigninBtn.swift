//
//  GoogleSignIn.swift
//  iDecide
//
//  Created by Kate Lukacs on 24/04/23.
//
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}


import SwiftUI

struct GoogleSigninBtn: View {
    var action: () -> Void
    @Binding var text: String

    var body: some View {
        
        VStack(spacing:0){
            TextField("Username", text: $text)
                .foregroundColor(Color.black)
                .font(.system(size: 20))
                .padding()
                .frame(width: 300.0, height: 60.0)
                .background(Color("Grey"))
                .roundedCorner(20, corners: [.topLeft, .topRight])
            Divider()
                .frame(width:300.0)
                .background(.black)
            TextField("Password", text: $text)
                .foregroundColor(Color.black)
                .font(.system(size: 20))
                .padding()
                .frame(width: 300.0, height: 60.0)
                .background(Color("Grey"))
                .roundedCorner(20, corners: [.bottomRight, .bottomLeft])
        }
    }
}

struct GoogleSigninBtn_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSigninBtn(action: {}, text: .constant(""))
    }
}

