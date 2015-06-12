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
    
    var imageURL = ""
    
    var parsedImageJSON: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    
    let imName = imageName.stringByReplacingOccurrencesOfString(" ", withString: "_")
    
    let imageJSONURL: NSURL = NSURL(string: ("http://scientolipedia.org/w/api.php?action=query&list=allimages&aiprefix=" + imName + "&format=json").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(imageJSONURL, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            if error == nil {
                
                var parsingAuditorError: NSError? = nil
                
                parsedImageJSON = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    imageURL = ""
                    
                } else {
                    
                    let imageJSONArray = parsedImageJSON["query"] as! [String: AnyObject]
                    
                    let imagesObject = imageJSONArray["allimages"] as! [[String: AnyObject]]
                    
                    let firstOne = imagesObject.first!
                    
                    imageURL = firstOne["url"] as! String

                }
                    
            }
        })

    
    task.resume()
    
    return imageURL
}