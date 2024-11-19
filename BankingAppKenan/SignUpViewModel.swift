//
//  AuthViewModel.swift
//  BankingApp
//
//  Created by Kenan on 13.11.24.
//
import Foundation
import RealmSwift

final class SignUpViewModel {
    private var userlist: Results<User>?

    
    func fetchdata(user: User) {
        do {
            let realm = try Realm()
            try  realm.write {
                realm.add(user)
            }
        }
        
        catch {
            print(error.localizedDescription)
        }
        
    }
    func getdata() {
        
        do {
            let realm = try Realm()
            var list = userlist
            print(list)
        }
        
        catch {
            print(error.localizedDescription)
        }

        
    }
    
    
    
    func validateFields(name: String, email: String, password: String, fin: String) -> String? {
        if name.isEmpty && name.prefix(1).uppercased() != name.prefix(1) {
            return ""
        }
        if !email.isValidEmail(email) {
            return ""
        }
        if password.count < 8 {
            return ""
        }
        if fin.count != 7 {
            return ""
        }
    
        return nil
    }
    
    func signupButtonTapped(name: String, email: String, password: String, fin: String) {
        if validateFields(name: name, email: email, password: password, fin: fin) != nil {
            
                
        } else {
            
            
        }
    }
}
