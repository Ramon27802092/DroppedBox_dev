//
//  Home.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFunctions
import FirebaseStorage
import FirebaseDatabase

struct Home: View {
    @State private var index = "Playstation"
    @State private var trackid = ""
    @State private var wifi = ""
    @State private var passWifi = ""
    @State private var menu = false
    @State private var widthMenu = UIScreen.main.bounds.width
    @State private var pedido = ""
    var device = UIDevice.current.userInterfaceIdiom
    @StateObject var login = FirebaseViewModel()
    @EnvironmentObject var loginShow : FirebaseViewModel
    @Environment(\.horizontalSizeClass) var width
    
    func getColumns() -> Int{
        return (device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavBar(index: $index, menu: $menu)
                ZStack{
                    if index == "My Packages" {
                        ZStack{
                            Color.white.edgesIgnoringSafeArea(.all)
                            VStack{
                                Text("Tracking Numbers Status")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.blue)
                                Spacer()
                                    .frame(height: 20)
                                Button(action: {
                                    let email = FirebaseViewModel.CredencialesUsuario.emailText
                                        login.observePedidos(email: email)
                                        pedido = FirebaseViewModel.CredencialesUsuario.pedidos
                                }){
                                    Text("Update")
                                        .font(.title)
                                        .frame(width: 200)
                                        .foregroundColor(Color.white)
                                    //.foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                                        .padding(.vertical,10)
                                }.background(
                                    Capsule()
                                        .stroke(Color.init(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                )
                                .frame(width: 200, height: 50)
                                .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                                Text(pedido)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.black)
                                    .onTapGesture {
                                        pedido = pedido
                                    }
                            }
                        }
                    }else if index == "Add Reader" {
                        ZStack{
                            Color.white.edgesIgnoringSafeArea(.all)
                            VStack{
                                //Image(systemName: "shippingbox.circle.fill").resizable().frame(width:250,height:250)
                                //Image("Logo").resizable().frame(width:250,height:250)
                                Text(" Configure Reader ")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.blue)
                                TextField("Enter WiFi name", text: $wifi)
                                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.black)
                                    .textCase(.uppercase)
                                    .padding()
                                    .frame(width: 350,height:50)
                                //.background(Color.black.opacity(0.05))
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
                                Spacer()
                                    .frame(height: 20)
                                TextField("Enter password WiFi", text: $passWifi)
                                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.black)
                                    .textCase(.uppercase)
                                    .padding()
                                    .frame(width: 350,height:50)
                                //.background(Color.black.opacity(0.05))
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
                                Spacer()
                                    .frame(height: 20)
                                Button(action: {
                                    
                                }){
                                    Text("Submit")
                                        .font(.title)
                                        .frame(width: 200)
                                        .foregroundColor(Color.white)
                                    //.foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                                        .padding(.vertical,10)
                                }.background(
                                    Capsule()
                                        .stroke(Color.init(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                )
                                .frame(width: 200, height: 50)
                                .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                            }.padding(.all)
                        }
                    }else{
                        ZStack{
                            Color.white.edgesIgnoringSafeArea(.all)
                            VStack{
                                //Image(systemName: "shippingbox.circle.fill").resizable().frame(width:250,height:250)
                                Image("Logo").resizable().frame(width:250,height:250)
                                Text("Add")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.blue)
                                Text("Tracking number")
                                    .font(.title2)
                                    .textCase(.uppercase)
                                    .foregroundColor(Color.gray)
                                TextField("Enter tracking number", text: $trackid)
                                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color.black)
                                    .textCase(.uppercase)
                                    .padding()
                                    .frame(width: 350,height:50)
                                //.background(Color.black.opacity(0.05))
                                    .background(Color.gray)
                                    .cornerRadius(10)
                                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
                                Spacer()
                                    .frame(height: 20)
                                Button(action: {
                                    let email = FirebaseViewModel.CredencialesUsuario.emailText
                                    login.createTrakingID(email: email, Tracking: trackid){(done) in
                                        if done{
                                            print("Registro exitoso")
                                        }
                                    }
                                }){
                                    Text("Submit")
                                        .font(.title)
                                        .frame(width: 200)
                                        .foregroundColor(Color.white)
                                    //.foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                                        .padding(.vertical,10)
                                }.background(
                                    Capsule()
                                        .stroke(Color.init(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                )
                                .frame(width: 200, height: 50)
                                .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                                /*Spacer()
                                 .frame(height: 100)
                                 HStack{
                                 Image(systemName: "house.fill").resizable().frame(width:50,height:50)
                                 Text("My \nPackages")
                                 Image(systemName: "web.camera").resizable().frame(width:50,height:50)
                                 Text("My \nDropped Box")
                                 //Image(systemName: "house.fill").resizable().frame(width:20,height:20)
                                 }*/
                            }.padding(.all)
                        }
                    }
                }
            }
            // termina navbar ipad
            if menu {
                HStack{
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:{
                                withAnimation{
                                    menu.toggle()
                                }
                            }){
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }.padding()
                        .padding(.top, 50)
                        VStack(alignment: .trailing){
                            ButtonView(index: $index, menu: $menu, title: "My Packages")
                            ButtonView(index: $index, menu: $menu, title: "Add Reader")
                            ButtonView(index: $index, menu: $menu, title: "Add Packages")
                            Button(action: {
                                try! Auth.auth().signOut()
                                UserDefaults.standard.removeObject(forKey: "sesion")
                                loginShow.show = false
                            }){
                                Text("Signout")
                                    .font(.title3)
                                    .foregroundColor(Color.gray)
                                    .bold()
                            }
                        }
                        Spacer()
                    }
                    .frame(width: widthMenu - 200)
                    //.background(Color.purple)
                    .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
                }
            }
        }.background(Color.white.opacity(0.9))
    }
}

