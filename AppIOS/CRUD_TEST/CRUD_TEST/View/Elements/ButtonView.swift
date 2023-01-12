//
//  ButtonView.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI

struct ButtonView: View {
    @Binding var index : String
    @Binding var menu : Bool
    var device = UIDevice.current.userInterfaceIdiom
    var title : String
    
    var body: some View {
        Button(action:{
            withAnimation{
                index = title
                if device == .phone{
                    menu.toggle()
                }
            }
        }){
            Text(title)
                .font(.headline)
                .fontWeight(index == title ? .bold : .none) // Se pone en negritas el seleccionado
                .foregroundColor(index == title ? .white : Color.white.opacity(0.6)) // similar al anterior pero se afecta el color
        }
    }
}


