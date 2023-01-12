//
//  ContentView.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginShow : FirebaseViewModel
    var body: some View {
        return Group{
            if loginShow.show{
                Home()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }else{
                Login()
                    .preferredColorScheme(.light)
            }
        // Es para mantener la sesion abierta
        }.onAppear{
            if (UserDefaults.standard.object(forKey: "sesion")) != nil {
                loginShow.show = true
            }
        }
    }
}
