//
//  File.swift
//  Fenris
//
//  Created by Wolfgang Schreurs on 01/08/2018.
//  Copyright © 2018 Wolftrail. All rights reserved.
//

import Foundation

/// Service locator errors.
///
/// - serviceAlreadyAdded: A service of the type is already added to the service locator.
/// - serviceNotAdded: A service of the type hasn't been added to the service locator.
enum ServiceLocatorError: Error {
    case serviceAlreadyAdded(LocatableService.Type)
    case serviceNotAdded(LocatableService.Type)
}

/// The ServiceLocator can be used to register and classes conforming to LocatableService. Use the
/// service locator to prevent creating a lot of singletons for instances you need to use accross
/// the app. Instead, register such classes with the service locator and retrieve them from the
/// service locator as needed. This prevents LocatableService from becoming hard to test.
open class ServiceLocator {
    public static let shared = ServiceLocator()
    
    private var serviceInfo: [String: LocatableService] = [:]
    
    private init() { /* Use the singleton instance. */ }
    
    /// Add a service.
    ///
    /// - Parameter service: The service to add.
    /// - Throws: An error if the service was already added. Please note only 1 service per type
    /// can be added.
    public func add<T: LocatableService>(service: T) throws {
        let typeName = String(describing: T.self)
        
        guard self.serviceInfo[typeName] == nil else {
            throw ServiceLocatorError.serviceAlreadyAdded(T.self)
        }
        
        self.serviceInfo[typeName] = service
    }
    
    /// Retrieve a service.
    ///
    /// - Parameter service: The service to retrieve.
    /// - Returns: The service.
    /// - Throws: An error if the service wasn't registered previously.
    public func get<T: LocatableService>(service: T.Type) throws -> T {
        let typeName = String(describing: service.self)
        
        guard let registeredService = self.serviceInfo[typeName] as? T else {
            throw ServiceLocatorError.serviceNotAdded(service)
        }
        
        return registeredService
    }
    
    /// Remove a registered service.
    ///
    /// - Parameter service: The service to remove.
    /// - Returns: True if the service was removed, false if the service wasn't found.
    public func remove<T: LocatableService>(service: T.Type) -> Bool {
        let typeName = String(describing: service.self)
        return self.serviceInfo.removeValue(forKey: typeName) != nil
    }
}

/// A marker protocol for any classes that are to be managed by the Service Locator.
public protocol LocatableService: class {}
