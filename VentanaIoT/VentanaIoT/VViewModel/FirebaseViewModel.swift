//
//  FirebaseViewModel.swift
//  VentanaIoT
//
//  Created by Ramon Jaramillo Martinez on 08/01/23.
//

import Foundation
import Firebase

class FirebaseViewModel: ObservableObject{
    @Published var show = false // Intercambiar vista principal y login
    func login(email:String, pass: String, completion: @escaping(_ done: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
            if user != nil{
                print("Entero")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en firebase",error)
                }else{
                    print("Error en la app")
                }
            }
        }
        
    }
}
