//
//  LoginScreen.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 29/10/22.
//

import SwiftUI


struct LoginScreen: View {
    @State private var password = ""
    @State private var email = ""
    @State var changePage = false
    var body: some View {
        VStack(alignment: .center) {
            Text("Welcome back!")
                .font(.largeTitle)
                .foregroundColor(Color.black)
            VStack(alignment: .leading){
                /*Text("Email address")
                 .multilineTextAlignment(.leading)
                 .padding()*/
                TextField("Email address", text: $email)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .textCase(.lowercase)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                /*Text("Password")
                 .padding()*/
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 350,height:50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //.backgroundStyle(Color.gray)
            }
            .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
            Spacer()
                .frame(height: 20)
            Button("Login") {
                self.changePage = true
            }
            .frame(width: 200, height: 50)
            .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
            .cornerRadius(10)
            .foregroundColor(Color.white)
            NavigationLink(destination: JoinScreen()){
                Text("Join Dropped Box!")
                    .fontWeight(.bold)
                .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 0.663, saturation: 1.0, brightness: 1.0)/*@END_MENU_TOKEN@*/)
            }
            Spacer()
                .frame(height: 10)
            NavigationLink(destination: RecoverScreen()){
                Text("Forgot password")
                    .font(.caption)
                .fontWeight(.semibold)
            
            }
            NavigationLink(destination: UserScreen(), isActive: self.$changePage){EmptyView()}.disabled(true)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
