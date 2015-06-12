//
//  AnthologyViewController.swift
//  Scientolipedia
//
//  Created by Brian on 6/5/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

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
    var titleS = ""
    var descriptionS = ""
    var birthDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(anthologyName)
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = ("http://scientolipedia.org/w/api.php?action=query&titles=" + anthologyURL + "&prop=revisions&rvprop=content&format=json" as NSString) as String
        
        anthologyURL = anthologyURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        anthologyURL = anthologyURL.stringByReplacingOccurrencesOfString("_&_", withString: "_%26_")
        
        println("AnthologyURL = " + anthologyURL)
        
        let pageURL = NSURL(string: anthologyURL)
        
        var parsingError: NSError? = nil
        
        let anthologyJSONData = NSData(contentsOfURL: pageURL!)
        println("AnthologyJSONData Successful")
        
        var parsedAnthologyData = NSJSONSerialization.JSONObjectWithData(anthologyJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        println("ParsedData was successful")
        
        var anthologyJSONArray = parsedAnthologyData["query"] as! [String: AnyObject]
        println("AnthologyJSONArray was successful")
        
        var this = anthologyJSONArray["pages"] as! NSDictionary
        println("this was successful")
        println(this)
        
        var dataForAnthology = this.allValues.last as! [String: AnyObject]
        println("ParsedData was successful")
        println(dataForAnthology)
        
        var goodToGo = false
        
        for item in dataForAnthology.keys.array {
            if item == "revisions" {
                goodToGo = true
            }
        }
        
        if goodToGo {
            var anthologyPageRevs = dataForAnthology["revisions"] as! [[String: AnyObject]]
            println("anthologyPageRev was successful")
            
            var completeData = anthologyPageRevs[0]
            
            println("completeData was successful")
            
            var theData: NSString = completeData["*"] as! NSString
            
            println(theData)
            
            theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")
            
            var theDataArray = theData.componentsSeparatedByString("\n") as! [NSString]
            
            for var i = 0; i < (theDataArray.count); i++ {
                
                theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                
                if theDataArray[i].hasPrefix("{") || theDataArray[i].hasPrefix("}") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Social=") || theDataArray[i].hasPrefix("== comments")  || theDataArray[i].hasPrefix("|titlemode=") || theDataArray[i].hasPrefix("|keywords=") || theDataArray[i].hasPrefix("|Image=") || theDataArray[i].hasPrefix("|Author=") || theDataArray[i].hasPrefix("|Type of Article=") || theDataArray[i].hasPrefix("|Topic=") {
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
                if theDataArray[i].hasPrefix("|title=") {
                    titleS = theDataArray[i].substringFromIndex(6)
                    theDataArray.removeAtIndex(i)
                    titleS = titleS.stringByReplacingOccurrencesOfString("=", withString: "")
                    i--; continue
                }
                if theDataArray[i].hasPrefix("|description=") {
                    descriptionS = theDataArray[i].substringFromIndex(12)
                    theDataArray.removeAtIndex(i)
                    descriptionS = descriptionS.stringByReplacingOccurrencesOfString("=", withString: "")
                    i--; continue
                }
                if theDataArray[i].hasPrefix("|Birthdate=") {
                    birthDate = theDataArray[i].substringFromIndex(10)
                    theDataArray.removeAtIndex(i)
                    birthDate = birthDate.stringByReplacingOccurrencesOfString("=", withString: "")
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
            
            if descriptionS != "" {
                theParagraph = "== Description ==\n" + descriptionS + "\n\n" + theParagraph
            }
            if titleS != "" {
                theParagraph = "== Title ==\n" + titleS + "\n\n" + theParagraph
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
            theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
    //        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("]", withString: "=")
    //        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[", withString: "=")
            
            theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br /> ", withString: "\n")
            theParagraph = theParagraph.stringByReplacingOccurrencesOfString("{{#seo:", withString: "")
            theParagraph = theParagraph.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            
            println("\n\n" + (theData as String))
            
            textView.text = theParagraph
            
            anthologyNameLabel.text = anthologyName
            
            self.textView.scrollRangeToVisible(NSRange(0...0)) 
        } else {
            
            self.navigationController?.popViewControllerAnimated(true)
            showAlertWithText(header: "Warning", message: "This page is corrupt and cannot load.")
        }
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func openPageButtonPressed(sender: UIBarButtonItem) {
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = ("http://scientolipedia.org/info/" + anthologyURL as NSString) as String
        
        anthologyURL = anthologyURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        UIApplication.sharedApplication().openURL(NSURL(string:anthologyURL)!)
        
    }



}
