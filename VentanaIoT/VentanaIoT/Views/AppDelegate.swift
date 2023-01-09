//
//  AppDelegate.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 24/12/22.
//

import UIKit
import Firebase
// Configuracion necesaria para trabajar con firebase 
class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
