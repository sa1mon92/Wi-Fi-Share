//
//  ContentView.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsModel
    @State private var selectedSegment = WiFiType.guest.rawValue
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SettingsView()) {
                    Label("Настройки", systemImage: "gearshape.fill")
                }
                .padding()
                
                Spacer(minLength: 100)
                
                GeometryReader { geometry in
                    QRCodeView(
                        text: getQRText(),
                        size: geometry.size.width
                    )
                }
                
                Spacer()
                
                Picker("", selection: $selectedSegment) {
                    Text(WiFiType.guest.description).tag(WiFiType.guest.rawValue)
                    Text(WiFiType.base.description).tag(WiFiType.base.rawValue)
                    Text(WiFiType.base5g.description).tag(WiFiType.base5g.rawValue)
                }
                .pickerStyle(.segmented)
                .padding()
            }
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 {
                            nextItem()
                        } else if value.translation.width > 50 {
                            previousItem()
                        }
                    }
            )
        }
    }
    
    func nextItem() {
        withAnimation {
            selectedSegment = (selectedSegment + 1) % WiFiType.allCases.count
        }
    }
    
    func previousItem() {
        withAnimation {
            selectedSegment = (selectedSegment - 1 + WiFiType.allCases.count) % WiFiType.allCases.count
        }
    }
    
    func getQRText() -> String {
        let type = WiFiType(rawValue: selectedSegment)
        switch type {
        case .guest:
            return "WIFI:T:WPA;S:\(settings.guestSSID);P:\(settings.guestPassword);;"
        case .base:
            return "WIFI:T:WPA;S:\(settings.baseSSID);P:\(settings.basePassword);;"
        case .base5g:
            return "WIFI:T:WPA;S:\(settings.base5GSSID);P:\(settings.base5GPassword);;"
        default:
            return ""
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SettingsModel())
}
