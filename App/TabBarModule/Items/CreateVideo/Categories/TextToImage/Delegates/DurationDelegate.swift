//
//  DurationDelegate.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 06.12.2024.
//

import Foundation

protocol DurationDelegate: AnyObject {
    func setValue(_ duration: String?)
    func isShowView(_ bool: Bool)
}
