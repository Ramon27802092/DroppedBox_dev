
//
//  Login.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI
import Firebase
struct Login: View{
    @State private var email = ""
    @State private var pass = ""
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    var device = UIDevice.current.userInterfaceIdiom
    var body: some View{
        ZStack{
            //Color.blue.edgesIgnoringSafeArea(.all)
            //Color.init(hue: 0.592, saturation: 1.0, brightness: 0.617).edgesIgnoringSafeArea(.all)
            Color.white.edgesIgnoringSafeArea(.all)
            //.edgesIgnoringSafeArea(.all)
            VStack{
                Image("Logo").resizable()
                    .frame(width: 300, height: 300).background(Color.gray).clipShape(Circle())
                Text("Dropped Box")
                    .font(.largeTitle)
                    //.foregroundColor(.white)
                    .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: device == .pad ? 400 : nil)
                SecureField("Password", text: $pass)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: device == .pad ? 400 : nil)
                    .foregroundColor(Color.gray)
                Button(action: {
                    FirebaseViewModel.CredencialesUsuario.emailText = email
                    login.login(email: email, pass: pass){(done) in
                        if done {
                            UserDefaults.standard.set(true, forKey: "sesion")
                            login.observeDataIP(email: email)
                            loginShow.show.toggle()
                        }
                    }
                    
                }){
                    Text("Login")
                        .font(.title)
                        .frame(width: 200)
                        //.foregroundColor(.white)
                        .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                        .padding(.vertical,10)
                }.background(
                    Capsule()
                        .stroke(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                )
                
                //Divider()
                Button(action: {
                    FirebaseViewModel.CredencialesUsuario.emailText = email
                    login.createUser(email: email, pass: pass){(done) in
                        if done {
                            UserDefaults.standard.set(true, forKey: "sesion")
                            login.observeDataIP(email: email)
                            loginShow.show.toggle()
                        }
                    }
                    
                }){
                    Text("Sign Up")
                        .font(.title)
                        .frame(width: 200)
                        //.foregroundColor(.white)
                        .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                        .padding(.vertical,10)
                }.background(
                    Capsule()
                        .stroke(Color.init(hue: 0.592, saturation: 1.0, brightness: 0.617))
                )
            }.padding(.all)
            
        }//.background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
    }
}
