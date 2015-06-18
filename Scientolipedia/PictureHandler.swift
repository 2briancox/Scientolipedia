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
        
        let imageJSONURL: NSURL = NSURL(string: ("http://scientolipedia.org/w/api.php?action=query&list=allimages&aiprefix=" + imName + "&format=json").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        
        var parsedJSONData = NSData(contentsOfURL: imageJSONURL)
                
        var parsingAuditorError: NSError? = nil
                
        var parsedImageJSON = NSJSONSerialization.JSONObjectWithData(parsedJSONData!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
        
        let imageJSONArray = parsedImageJSON["query"] as! [String: AnyObject]
        
        let imagesObject = imageJSONArray["allimages"] as! [[String: AnyObject]]
        
        let firstOne = imagesObject.first!
        
        let imageURL = firstOne["url"] as! String

        return imageURL
        
    }
