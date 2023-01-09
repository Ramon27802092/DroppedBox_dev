//
//  UserScreen.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 29/10/22.
//

import SwiftUI

struct UserScreen: View {
    @State private var password = ""
    @State private var email = ""
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "shippingbox.circle.fill").resizable().frame(width:250,height:250)
            Text("Add")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
            Text("Tracking number")
                .font(.title2)
                .textCase(.uppercase)
                .foregroundColor(Color.gray)
            TextField("Enter tracking number", text: $email)
                .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .textCase(.uppercase)
                .padding()
                .frame(width: 350,height:50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing], 1.0/*@END_MENU_TOKEN@*/)
            Spacer()
                .frame(height: 20)
            Button("Sumbit") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .frame(width: 200, height: 50)
            .background(Color(hue: 0.592, saturation: 1.0, brightness: 0.617))
            .cornerRadius(10)
            .foregroundColor(Color.white)
            Spacer()
                .frame(height: 100)
            HStack{
                Image(systemName: "house.fill").resizable().frame(width:50,height:50)
                Text("My \nPackages")
                Image(systemName: "web.camera").resizable().frame(width:50,height:50)
                Text("My \nDropped Box")
                //Image(systemName: "house.fill").resizable().frame(width:20,height:20)
            }
        }
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserScreen()
    }
}
