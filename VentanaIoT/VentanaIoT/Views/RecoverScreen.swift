//
//  RecoverScreen.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 29/10/22.
//

import SwiftUI

struct RecoverScreen: View {
    @State private var email = ""
    var body: some View {
        VStack(alignment: .center) {
            Text("Forgot Password!")
                .font(.largeTitle)
                .foregroundColor(Color.black)
            VStack(alignment: .leading){
                /*Text("Email address")
                 .multilineTextAlignment(.leading)
                 .padding()*/
                TextField("Enter your email address", text: $email)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    //.textCase(.lowercase)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
            }
            Spacer()
                .frame(height: 20)
            Button("Reset password") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .frame(width: 200, height: 50)
            .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
            .cornerRadius(10)
            .foregroundColor(Color.white)
        }
    }
}

struct RecoverScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecoverScreen()
    }
}
