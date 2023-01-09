//
//  ContentView.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 27/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: LoginScreen()){
            VStack{
                Image("Logo").resizable()
                    .frame(width: 300, height: 300).background(Color.gray).clipShape(Circle())
                Text("Click to continue ...")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
                    //.navigationBarTitle("Navigation")
                }
            }
        }
    }
}
/*
            VStack{
                Image("Logo").resizable()
                    .frame(width: 300, height: 300).background(Color.gray).clipShape(Circle())
                
                Text("Click to continue ...")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(hue: 0.64, saturation: 1.0, brightness: 1.0))
            }
        }
    }
}*/

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
