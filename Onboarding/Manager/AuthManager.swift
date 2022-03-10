//
//  AuthManager.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//

import Foundation
import FirebaseAuth

struct AuthManager {
    
    private let auth = Auth.auth()

    
    func signUpNewUser(withEmail email: String, password: String, completion:  @escaping (Result<User, Error>) ->()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unKnown))
            }
        }
    }
    
    
    
    func loginUser(withEmail email: String, password: String, completion:  @escaping (Result<User, Error>) ->()) {
        auth.signIn(withEmail: email, password: password) {   result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                completion(.success(user))
            } else {
                completion(.failure(AuthError.unKnown))
            }
        }
    }
    
    
    func logoutUser() -> Result<Void, Error> {
        do {
            try auth.signOut()
            return .success(())
        } catch (let error) {
            return .failure(error)
        }
    }
    
    
    func resetPassword(withEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
     var isUserLoggedIn : Bool  {
        return Auth.auth().currentUser != nil
    }

    
    
}


enum AuthError: Error {
    case unKnown
}

extension AuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unKnown:
            return NSLocalizedString("Something went wrong ,please try again", comment: "My error")
        }
    }
}
