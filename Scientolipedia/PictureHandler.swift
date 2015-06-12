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
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "...")!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            // var definition = ""
            
            if error == nil {
                
                // var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                //
                // var urlContentArray: [String] = []
                //
                // var hasTable = false
                //
                // var takenFromLink = false
                //
                // if urlContent.containsString("</td></tr></table>\n<p>") {
                // ...
                
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    return nil
                    
                } else {
                    //     if (definition as NSString).containsString("</span><span class=\"mw-lingo-tooltip-tip \"><span class=\"mw-lingo-tooltip-definition \">") {
                    //         definition = definition.componentsSeparatedByString("</span><span class=\"mw-lingo-tooltip-tip \"><span class=\"mw-lingo-tooltip-definition \">")[1]
                    //     }
                    //
                    //     self.definitionTextView.text = definition
                    //     self.wordTitleLabel.textColor = UIColor(white: CGFloat(0.0), alpha: CGFloat(1.0))
                    //     self.definitionTextView.textColor = UIColor(white: CGFloat(0.0), alpha: CGFloat(1.0))
                    //     self.definitionTextView.scrollRangeToVisible(NSRange(0...0))
                    
            }
        }
        
    })
    
    task.resume()
    
    var parsingAuditorError: NSError? = nil
    
    let imageJSON = NSData(contentsOfURL: imageJSONURL, options: nil, error: nil)
    
    let parsedImageJSON = NSJSONSerialization.JSONObjectWithData(imageJSON!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
    
    let imageJSONArray = parsedImageJSON["query"] as! [String: AnyObject]
    
    let imagesObject = imageJSONArray["allimages"] as! [[String: AnyObject]]
    
    let firstOne = imagesObject.first!
    
    let imageUrl = firstOne["url"] as! String

    return imageUrl
    
}