//
//  FirebaseViewModel.swift
//  DroppedBox
//
//  Created by Ramon Jaramillo Martinez on 09/01/23.
//  Es de suma importancia no modificar el nombre del archivo GoogleService-info, de lo
//  contrario saldra error.

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFunctions

class FirebaseViewModel: ObservableObject{
    @Published var show = false
    var ref: DatabaseReference!
    func login(email:String, pass:String, completion: @escaping (_ done: Bool) -> Void ){
        Auth.auth().signIn(withEmail: email, password: pass) {(user, error) in
            if user != nil {
                print("Entro")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en firebase",error)
                }else{
                    print("Error en la aplicacion")
                }
            }
        }
    }
    func createUser(email:String, pass:String, completion: @escaping (_ done: Bool) -> Void ){
        Auth.auth().createUser(withEmail: email, password: pass){(user, error) in
            let correo = email
            if user != nil {
                let newString = correo.replacingOccurrences(of: ".", with: "+")
                /*if let i = correo.firstIndex(of: "."){
                    correo.remove(at: i)
                }
                
                if let i = correo.firstIndex(of: "@"){
                    correo.remove(at: i)
                }
                if let i = correo.firstIndex(of: "#"){
                    correo.remove(at: i)
                }*/
                //print(correo)
                self.ref = Database.database().reference()
                self.ref.child("LoginSingup").child("\(newString)").setValue(["correo":"\(newString)"])
                self.ref.child("LoginSingup").child("\(newString)").child("estado").setValue(["accion":"na","pedido":"na"])
                //self.ref.child("usuarios/\(correo)/correo").setValue("Ramon")
                print("Entro y se registro")
                completion(true)
            }else{
                if let error = error?.localizedDescription{
                    print("Error en firebase",error)
                }else{
                    print("Error en la aplicacion")
                }
            }
        }
    }
    func createTrakingID(email:String, Tracking:String, completion: @escaping (_ done: Bool) -> Void ){
        let correo = email
        let newString = correo.replacingOccurrences(of: ".", with: "+")
        self.ref = Database.database().reference()
        self.ref.child("LoginSingup").child("\(newString)").child("pedidos").child("pedidos"+"\(Tracking)").setValue(["ID":"\(Tracking)","Status":"Pendiente"])
        //self.ref.child("usuarios/\(correo)/correo").setValue("Ramon")
        //print("Entro y se registro")
        completion(true)
        }
    func observeDataIP(email:String){
        let correo = email
        let newString = correo.replacingOccurrences(of: ".", with: "+")
        self.ref = Database.database().reference()
        self.ref.child("LoginSingup").child("\(newString)").child("urls").child("ipglector").getData(completion: {error, snapshot in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            let ipglobal = snapshot?.value as? String ?? "Unknown"
            print("\(ipglobal)")
            CredencialesUsuario.ipglobal = ipglobal
            let test = CredencialesUsuario.ipglobal
            print(test)
            //FirebaseViewModel.CredencialesUsuario.ipglobal = ipglobal
        })
    }
    func observePedidos(email:String){
        let correo = email
        let newString = correo.replacingOccurrences(of: ".", with: "+")
        self.ref = Database.database().reference()
        self.ref.child("LoginSingup").child("\(newString)").child("pedidos").observeSingleEvent(of: .value, with: {snapshot in
            if let pedidos = snapshot.value as? [String: Any]{
                print(type(of: pedidos))
                var listapedidos = " "
                for (_, value) in pedidos {
                    //print("Value: \(value) for key: \(key)")
                    let PedidoID = "\(value)"
                    let newPedido = PedidoID.replacingOccurrences(of: "{", with:"Pedido:")
                    let newPedido2 = newPedido.replacingOccurrences(of: "}", with:"\n")
                    listapedidos = newPedido2 + listapedidos
                }
                /*for(title,details) in pedidos{
                    for (key, value) in pedidos {
                        print("Value: \(value) for key: \(key)")
                        print(type(of: value))
                        print(type(of: key))
                    }
                    print(title)
                    print(newString)
                    print(type(of: details))
                    listapedidos = title + "\n" + listapedidos
                    print(type(of: title))
                    //print(details)
                }*/
                
                CredencialesUsuario.pedidos = listapedidos
                let temp = CredencialesUsuario.pedidos
                print(temp)
            }
        }){(error) in
            print(error.localizedDescription)
        }
    }
    // Estructura para almacenar variables globales
    struct CredencialesUsuario{
        static var emailText = "default"
        static var ipglobal = "https://developer.apple.com/forums/thread/666821"
        static var pedidos = "Empy"
        static var status = "default"
    }
}
