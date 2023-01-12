//
//  SafariWebView.swift
//  CRUD_TEST
//
//  Created by Ramon Jaramillo Martinez on 10/01/23.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable{
    let url: String
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: URL(string: url)!)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }
}

