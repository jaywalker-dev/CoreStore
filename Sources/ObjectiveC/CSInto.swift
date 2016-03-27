//
//  CSInto.swift
//  CoreStore
//
//  Copyright © 2016 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import CoreData


// MARK: - CSInto

/**
 The `CSInto` serves as the Objective-C bridging type for `Into<T>`.
 */
@objc
public final class CSInto: NSObject, CoreStoreBridge {
    
    /**
     Initializes a `CSInto` clause with the specified entity class.
     ```
     MyPersonEntity *person = [transaction createInto:[CSInto entityClass:[MyPersonEntity class]]];
     ```
     - parameter entityClass: the `NSManagedObject` class type to be created
     - returns: a `CSInto` clause with the specified entity class
     */
    @objc
    public static func entityClass(entityClass: AnyClass) -> CSInto {
        
        return self.init(Into(entityClass))
    }
    
    /**
     Initializes a `CSInto` clause with the specified configuration.
     ```
     MyPersonEntity *person = [transaction createInto:[CSInto entityClass:[MyPersonEntity class]]];
     ```
     - parameter entityClass: the `NSManagedObject` class type to be created
     - parameter configuration: the `NSPersistentStore` configuration name to associate the object to. This parameter is required if multiple configurations contain the created `NSManagedObject`'s entity type. Set to `nil` to use the default configuration.
     - returns: a `CSInto` clause with the specified configuration
     */
    @objc
    public static func entityClass(entityClass: AnyClass, configuration: String?) -> CSInto {
        
        return self.init(Into(entityClass, configuration))
    }
    

    // MARK: NSObject
    
    public override var hash: Int {
        
        return self.swift.hashValue
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        
        guard let object = object as? CSInto else {
            
            return false
        }
        return self.swift == object.swift
    }
    
    
    // MARK: CoreStoreBridge
    
    internal let swift: Into<NSManagedObject>
    
    public required init<T: NSManagedObject>(_ swiftObject: Into<T>) {
        
        self.swift = Into<NSManagedObject>(
            entityClass: swiftObject.entityClass,
            configuration: swiftObject.configuration,
            inferStoreIfPossible: swiftObject.inferStoreIfPossible
        )
        super.init()
    }
}


// MARK: - Into

extension Into: CoreStoreBridgeable {
    
    // MARK: CoreStoreBridgeable
    
    internal var objc: CSInto {
        
        return CSInto(self)
    }
}
