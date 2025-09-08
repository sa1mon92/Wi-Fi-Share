//
//  SettingsView.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsModel
    
    var body: some View {
        Form {
            Section(header: Text("Гостевой Wi-Fi")) {
                ParametersView(title: "SSID", text: $settings.guestSSID)
                ParametersView(title: "Пароль", text: $settings.guestPassword, isSecure: true)
            }
            
            Section(header: Text("Основной Wi-Fi")) {
                ParametersView(title: "SSID", text: $settings.baseSSID)
                ParametersView(title: "Пароль", text: $settings.basePassword, isSecure: true)
            }
            
            Section(header: Text("Основной Wi-Fi (5G)")) {
                ParametersView(title: "SSID", text: $settings.base5GSSID)
                ParametersView(title: "Пароль", text: $settings.base5GPassword, isSecure: true)
            }
        }
        .navigationTitle("Настройки Wi-Fi")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            settings.save()
        }
    }
}

struct ParametersView: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
        }
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never) // современный вариант
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsModel())
}
