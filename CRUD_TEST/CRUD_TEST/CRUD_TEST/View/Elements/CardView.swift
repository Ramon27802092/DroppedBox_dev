//
//  CardView.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(spacing: 20){
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("TitanFall 2")
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }.padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

