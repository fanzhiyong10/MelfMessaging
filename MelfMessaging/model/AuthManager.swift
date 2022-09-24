//
//  AuthManager.swift
//  MelfMessaging
//
//  Created by 范志勇 on 2022/9/19.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var signedIn: Bool {true}
    var accesToken: String?
    var refreshToken: String?
    var tokenExpirationDate: String?

    private var shouldRefreshToken: Bool {false}
}
