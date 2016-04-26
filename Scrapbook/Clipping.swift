//
//  Clipping.swift
//  Scrapbook
//
//  Created by Ben Johnson on 18/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit
import CoreData


class Clipping: NSManagedObject {
    
    lazy var image: UIImage? = {
        
        if let imageURL = self.imageURL, dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(imageURL)
            
            let checkValidation = NSFileManager.defaultManager()
            
            if (checkValidation.fileExistsAtPath(path))
            {
                print("FILE AVAILABLE");
            } else {
                fatalError("File Not Found")
            }
            
            return UIImage(contentsOfFile: path)
         
        }
        return nil
        
    }()
    
    func addImage(image: UIImage) {
        
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            
            let filename = "\(String.randomStringWithLength(8)).jpg"
            let path = dir.stringByAppendingPathComponent(filename)
            
            print(path)
            UIImageJPEGRepresentation(image,1.0)!.writeToFile(path, atomically: true)
            
            imageURL = filename
            let checkValidation = NSFileManager.defaultManager()
            
            
            if (checkValidation.fileExistsAtPath(path))
            {
                print("FILE AVAILABLE");
            } else {
                fatalError("File Not Found")
            }

            
    }

}
}
