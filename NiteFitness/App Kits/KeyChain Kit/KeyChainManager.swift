//
//  KeyChainManager.swift
//  myElcom
//
//  Created by Valerian on 16/05/2022.
//

import KeychainAccess

class KeyChainManager {

    static let shared = KeyChainManager()
    private let keychain = Keychain(service: "myElcom")

    private init() {
        //
    }

    var accessToken: String? {
        get {
            return self.keychain[Key.accessToken]
        }

        set {
            self.keychain[Key.accessToken] = newValue
        }
    }

    var userAgent: String? {
        get {
            return self.keychain[Key.userAgent]
        }

        set {
            self.keychain[Key.userAgent] = newValue
        }
    }

    var encryptionKey: Data {
        get {
            if let key = try? self.keychain.getData(Key.encrytionKey) {
                return key
            } else {
                // Genarate random encryption key
                let keyData = NSMutableData(length: 64)!
                 //_ = SecRandomCopyBytes(kSecRandomDefault, 64, keyData .mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
                try? self.keychain.set(keyData as Data, key: Key.encrytionKey)
                return keyData as Data
            }
        }

        set {
            try? self.keychain.set(newValue, key: Key.encrytionKey)
        }
    }

    func removeKey(_ key: String) {
        try? self.keychain.remove(key)
    }
}

