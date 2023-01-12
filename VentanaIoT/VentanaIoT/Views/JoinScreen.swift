//
//  JoinScreen.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 29/10/22.
//

import SwiftUI

struct JoinScreen: View {
    @State private var name = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var email02 = ""
    @State private var password = ""
    @State private var password02 = ""
    var body: some View {
        VStack(alignment: .center) {
            Text("Please enter your personal info!")
                .font(.title)
                .foregroundColor(Color.black)
            VStack(alignment: .leading){
                TextField("Enter your name", text: $name)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                TextField("Enter your last name", text: $lastname)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                TextField("Enter your email address", text: $email)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    //.textCase(.lowercase)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                TextField("Re enter your email address", text: $email02)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    //.textCase(.lowercase)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                TextField("Enter your password", text: $password)
                    .accessibilityAddTraits([.isHeader])
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .accessibilityLabel("Password")
                TextField("Re enter your password", text: $password02)
                    .accessibilityAddTraits([.isHeader])
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .accessibilityLabel("Password")
                //.backgroundStyle(Color.gray)
            }
            .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
            Spacer()
                .frame(height: 20)
            Button("Sign Up") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .frame(width: 200, height: 50)
            .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
            .cornerRadius(10)
            .foregroundColor(Color.white)
        }
    }
}

struct JoinScreen_Previews: PreviewProvider {
    static var previews: some View {
        JoinScreen()
    }
}
