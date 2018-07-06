//
//  KeychainWrapper.swift
//  KeyChain101
//
//  Created by madi on 7/6/18.
//  Copyright © 2018 madi. All rights reserved.
//

import UIKit

class KeychainWrapper {
    func addData(with value: String, forKey: String) {
        addKeychainData(forkey: forKey, withValue: value)
    }
    
    func getData(forKey: String) -> NSData? {
        return getKeychainData(for: forKey)
    }
    
    fileprivate func addKeychainData(forkey key: String, withValue value: String) {
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: .utf8) as Any
        ]
        
        SecItemDelete(addQuery as CFDictionary)
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            print("Keychain add failed...")
            return
        }
    }
    
    fileprivate func getKeychainData(for key: String) -> NSData? {
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: CFTypeRef?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &dataTypeRef)
        if status == noErr && dataTypeRef != nil {
            return dataTypeRef as? NSData
        }
        
        return nil
    }
}
