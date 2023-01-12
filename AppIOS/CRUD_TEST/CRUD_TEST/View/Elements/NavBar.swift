//
//  NavBar.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI
import Firebase
struct NavBar: View {
    @State private var showSafariWebView = false
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var index : String
    @Binding var menu : Bool
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    var body: some View {
        let url = FirebaseViewModel.CredencialesUsuario.ipglobal
        HStack{
            Text("Dropped Box")
                .font(.title)
                .bold()
                .foregroundColor(.black)
                .font(.system(size: device == .phone ? 25 : 35))
            Spacer()
            if device == .pad {
                // menu ipad
                HStack(spacing: 25){
                    ButtonView(index: $index, menu: $menu, title: "My Packages")
                    ButtonView(index: $index, menu: $menu, title: "Add Reader")
                    ButtonView(index: $index, menu: $menu, title: "Add Packages")
                    Button(action: {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.removeObject(forKey: "sesion")
                        loginShow.show = false
                    }){
                        Text("Salir")
                            .font(.title)
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .padding(.horizontal, 7)
                    }.background(
                        Capsule().stroke(Color.white)
                    )
                }.bold()
            }else{
                // menu iphone
                Button(action:{
                    index = "Agregar" //#######################
                    showSafariWebView = true
                }){
                    Image(systemName: "web.camera")
                        .font(.system(size: 26))
                        .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                }.sheet(isPresented: $showSafariWebView){
                    SafariWebView(url: url)
                }
                Button(action:{
                    withAnimation{
                        menu.toggle()
                    }
                }){
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 26))
                        .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                        //.foregroundColor(.white)
                }
            }
                
        }
        .padding(.top, 30)
        .padding()
        .background(Color.white)
        //.background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
    }
}


