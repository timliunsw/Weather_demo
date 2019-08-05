//
//  NSObject+Extension.swift
//  Weather
//
//  Created by Tim Li on 3/8/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation

public extension NSObject {
    class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
