//
//  SettingsModel.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import SwiftUI

class SettingsModel: ObservableObject {
    @Published var guestSSID: String
    @Published var guestPassword: String
    
    @Published var baseSSID: String
    @Published var basePassword: String
    
    @Published var base5GSSID: String
    @Published var base5GPassword: String
    
    init() {
        guestSSID = UserDefaults.standard.string(forKey: "guestSSID") ?? ""
        guestPassword = UserDefaults.standard.string(forKey: "guestPassword") ?? ""
        baseSSID = UserDefaults.standard.string(forKey: "baseSSID") ?? ""
        basePassword = UserDefaults.standard.string(forKey: "basePassword") ?? ""
        base5GSSID = UserDefaults.standard.string(forKey: "base5GSSID") ?? ""
        base5GPassword = UserDefaults.standard.string(forKey: "base5GPassword") ?? ""
    }
    
    func save() {
        UserDefaults.standard.set(guestSSID, forKey: "guestSSID")
        UserDefaults.standard.set(guestPassword, forKey: "guestPassword")
        UserDefaults.standard.set(baseSSID, forKey: "baseSSID")
        UserDefaults.standard.set(basePassword, forKey: "basePassword")
        UserDefaults.standard.set(base5GSSID, forKey: "base5GSSID")
        UserDefaults.standard.set(base5GPassword, forKey: "base5GPassword")
    }
    
    func getQRText(for type: WiFiType) -> String {
        switch type {
        case .guest:
            return "WIFI:T:WPA;S:\(guestSSID);P:\(guestPassword);;"
        case .base:
            return "WIFI:T:WPA;S:\(baseSSID);P:\(basePassword);;"
        case .base5g:
            return "WIFI:T:WPA;S:\(base5GSSID);P:\(base5GPassword);;"
        }
    }
}
