//
//  VentanaIoTApp.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 27/10/22.
//  Este archivo es el ciclo de vida de la aplicacion

import SwiftUI

@main
struct VentanaIoTApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // Linea necesaria para agregar firebase a la aplicacion
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
