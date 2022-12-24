//
//  Constants.swift
//  FinalProject
//
//  Created by Ahmed Hinawi on 15/12/2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class Constants {
    static let dbPath           = Database.database().reference()
    static let storagePath      = Storage.storage().reference()
    
    static let users_path        = dbPath.child("users")
    static let orders_path       = dbPath.child("orders")
}
