//
//  Extensions.swift
//  Scrapbook
//
//  Created by Benjamin Johnson on 26/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import Foundation


// From http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
// Used for generating random filename for clipping images

extension String {
   static func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
}

// http://stackoverflow.com/questions/32501627/stringbyappendingpathcomponent-is-unavailable
extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    var length: Int {
        return characters.count
    }
}

