//
//  AnthologyViewController.swift
//  Scientolipedia
//
//  Created by Brian on 6/5/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class AnthologyViewController: UIViewController {

    @IBOutlet weak var anthologyNameLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var openInBrowser: UIBarButtonItem!
    
    var anthologyName: String = ""
    
    var name = ""
    var period = ""
    var location = ""
    var year = ""
    var email = ""
    var website = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = ("http://scientolipedia.org/w/api.php?action=query&titles=" + anthologyURL + "&prop=revisions&rvprop=content&format=json" as NSString) as String
        
        anthologyURL = anthologyURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let pageURL = NSURL(string: anthologyURL)
        
        var parsingError: NSError? = nil
        
        let anthologyJSONData = NSData(contentsOfURL: pageURL!)
        
        var parsedAnthologyData = NSJSONSerialization.JSONObjectWithData(anthologyJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        
        var anthologyJSONArray = parsedAnthologyData["query"] as! [String: AnyObject]
        
        var this = anthologyJSONArray["pages"] as! NSDictionary
        
        var dataForAnthology = this.allValues.last as! [String: AnyObject]
        
        var anthologyPageRevs = dataForAnthology["revisions"] as! [[String: AnyObject]]
        
        var completeData = anthologyPageRevs[0]
        
        var theData: NSString = completeData["*"] as! NSString
        
        println(theData)
        
        theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")
        
        var theDataArray = theData.componentsSeparatedByString("\n") as! [NSString]
        
        for var i = 0; i < (theDataArray.count); i++ {
            
            theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            
            if theDataArray[i].containsString("{") || theDataArray[i].containsString("}") || theDataArray[i].containsString("<") || theDataArray[i].containsString(">") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Social=") || theDataArray[i].hasPrefix("== comments")  || theDataArray[i].hasPrefix("|titlemode=") || theDataArray[i].hasPrefix("|keywords=") || theDataArray[i].hasPrefix("|Image=") || theDataArray[i].hasPrefix("|Author=") || theDataArray[i].hasPrefix("|Type of Article=") || theDataArray[i].hasPrefix("|Topic=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Name=") {
                name = theDataArray[i].substringFromIndex(5)
                theDataArray.removeAtIndex(i)
                name = name.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Period=") {
                period = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                period = period.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Location=") {
                location = theDataArray[i].substringFromIndex(9)
                theDataArray.removeAtIndex(i)
                location = location.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Year=") {
                year = theDataArray[i].substringFromIndex(5)
                theDataArray.removeAtIndex(i)
                year = year.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Email=") {
                email = theDataArray[i].substringFromIndex(6)
                theDataArray.removeAtIndex(i)
                email = email.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }

            if theDataArray[i].hasPrefix("|Website=") {
                website = theDataArray[i].substringFromIndex(8)
                theDataArray.removeAtIndex(i)
                website = website.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }

        }
        
        var theParagraph = ""
        
        for var i = 0; i < theDataArray.count; i++ {
            if theDataArray[i].substringToIndex(1) == "=" {
                theParagraph += "\n\n"
            }
            theParagraph = theParagraph + (theDataArray[i] as String) + " "
            if theDataArray[i].substringFromIndex(theDataArray[i].length - 1)  == "=" || theDataArray[i].substringFromIndex(theDataArray[i].length - 1)  == ":" {
                theParagraph += "\n"
            }
        }
        
        if email != "" {
            theParagraph = "== Email ==\n" + email + "\n\n" + theParagraph
        }
        if website != "" {
            theParagraph = "== Website ==\n" + website + "\n\n" + theParagraph
        }
        if year != "" {
            theParagraph = "== Year ==\n" + year + "\n\n" + theParagraph
        }
        if location != "" {
            theParagraph = "== Location ==\n" + location + "\n\n" + theParagraph
        }
        if period != "" {
            theParagraph = "== Period ==\n" + period + "\n\n" + theParagraph
        }
        if name != "" {
            theParagraph = "== Name ==\n" + name + "\n\n" + theParagraph
        }
        
        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
        
        textView.text = theParagraph
        
        anthologyNameLabel.text = anthologyName
        
        self.textView.scrollRangeToVisible(NSRange(0...0))
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPageButtonPressed(sender: UIBarButtonItem) {
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = ("http://scientolipedia.org/info/" + anthologyURL as NSString) as String
        
        anthologyURL = anthologyURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        UIApplication.sharedApplication().openURL(NSURL(string:anthologyURL)!)
        
    }



}
