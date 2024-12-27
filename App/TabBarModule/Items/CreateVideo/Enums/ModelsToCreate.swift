//
//  CreateModels.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 12.12.2024.
//

import Foundation

enum ModelsToCreate {
    case firstModel
    case secondModel
    case threeModel
    
    var value: String {
        switch self {
        case .firstModel:
            return "Dinson Pro".localized(LanguageConstant.appLaunguage)
        case .secondModel:
            return "Dinson Standart".localized(LanguageConstant.appLaunguage)
        case .threeModel:
            return "Natash".localized(LanguageConstant.appLaunguage)
        }
    }
}
