//
//  AppData.swift
//  CreateAIVideo
//
//  Created by Vasiliy Vygnych on 15.10.2024.
//

import Foundation
import CoreData

@objc(AppData)
public class AppData: NSManagedObject {}
extension AppData {
    @NSManaged public var id: Int16
    @NSManaged public var dateOfSubscripe: Date
    
    @NSManaged public var plusUpdateDate: Date
    @NSManaged public var ultraUpdateDate: Date
    @NSManaged public var freeUpdateDate: Date
    
    @NSManaged public var freeGenerationTime: Double
    @NSManaged public var plusGenerationTime: Double
    @NSManaged public var albumLimitUltra: Int16
    @NSManaged public var albumLimitPlus: Int16
    

    @NSManaged public var subscripeID: String?
    @NSManaged public var subscripeType: String?
    
    @NSManaged public var isLogin: Bool
    
    @NSManaged public var freeIsActive: Bool
    @NSManaged public var plusIsActive: Bool
    @NSManaged public var ultraIsActive: Bool
    
    @NSManaged public var freeAccess: Bool
    @NSManaged public var isSubscripe: Bool
    
    @NSManaged public var restoreFreeMode: Bool
    @NSManaged public var restorePlusMode: Bool
    @NSManaged public var restoreUltimaMode: Bool
}
extension AppData : Identifiable {}
