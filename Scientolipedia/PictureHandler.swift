//
//  PictureHandler.swift
//  Scientolipedia
//
//  Created by Brian on 5/15/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import Foundation
import UIKit


    
    func showPic (imageName: String) -> String {
        
        let imName = imageName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        var imageJSONURLString = "http://scientolipedia.org/w/api.php?action=query&list=allimages&aiprefix=" + imName + "&format=json"
        
        var urlNSString: NSString = imageJSONURLString as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        imageJSONURLString = urlNSString as String
        
        let imageJSONURL = NSURL(string: imageJSONURLString)
        
        let parsedJSONData = NSData(contentsOfURL: imageJSONURL!)
        
        var parsedImageJSON = (try! NSJSONSerialization.JSONObjectWithData(parsedJSONData!, options: .AllowFragments)) as! [String: AnyObject]
        
        let imageJSONArray = parsedImageJSON["query"] as! [String: AnyObject]
        
        let imagesObject = imageJSONArray["allimages"] as! [[String: AnyObject]]
        
        let firstOne = imagesObject.first!
        
        let imageURL = firstOne["url"] as! String

        return imageURL
        
    }
