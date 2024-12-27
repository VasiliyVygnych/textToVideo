//
//  Enums.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 14.10.2024.
//

import Foundation

enum SubscriptionMode {
    case none
    case free
    case monthlyPlus
    case monthlyUltra
    case yearlyPlus
    case yearlyUltra
}

enum IDforCorData {
    static let monthlyPlus = "monthlyPlus"
    static let monthlyUltra = "monthlyUltra"
    static let yearlyPlus = "yearlyPlus"
    static let yearlyUltra = "yearlyPlus"
    static let free = "free"
}

enum SubscriptionType {
    static let free = "free"
    static let plus = "plus"
    static let Ultra = "ultra"
    static let none = "none"
}


enum SubscriptionID {
    static let monthlyPlus = "monthlyPlusAccess_01"
    static let monthlyUltra = "monthlyUltraAccess_02"
    static let yearlyPlus = "yearlyPlusAccess_03"
    static let yearlyUltra = "yearlyUltraAccess_04"
}

