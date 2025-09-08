//
//  WiFiType.swift
//  Wi-Fi Share
//
//  Created by Садырев Дмитрий on 08.09.2025.
//

import Foundation

enum WiFiType: Int {
    case guest
    case base
    case base5g
    
    var description: String {
        switch self {
        case .guest:
            return "Гостевой"
        case .base:
            return "Основной"
        case .base5g:
            return "Основной 5G"
        }
    }
}
