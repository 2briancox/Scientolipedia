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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        
        self.activityIndicator.startAnimating()
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        var parsedAnthologyData: [String: AnyObject] = Dictionary<String, AnyObject>()
        
        anthologyURL = ("http://scientolipedia.org/w/api.php?action=query&titles=" + anthologyURL + "&prop=revisions&rvprop=content&format=json" as NSString) as String
        
        println(anthologyURL)
        
        anthologyURL = anthologyURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        anthologyURL = anthologyURL.stringByReplacingOccurrencesOfString("_&_", withString: "_%26_")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: anthologyURL)!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            if error == nil {
                
                var parsingError: NSError? = nil
                
                parsedAnthologyData = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText(header: "Warning", message: "This page cannot load right now. Please try again.")
                    
                } else {
                    var anthologyJSONArray = parsedAnthologyData["query"] as! [String: AnyObject]
                    
                    var this = anthologyJSONArray["pages"] as! NSDictionary
                    
                    var dataForAnthology = this.allValues.last as! [String: AnyObject]
                    
                    var goodToGo = false
                    
                    for key in dataForAnthology.keys.array {
                        if key == "revisions" {
                            goodToGo = true
                        }
                    }
                    
                    if goodToGo {
                        var anthologyPageRevs = dataForAnthology["revisions"] as! [[String: AnyObject]]
                        
                        var completeData = anthologyPageRevs[0]
                        
                        var theData: NSString = completeData["*"] as! NSString
                        
                        theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")
                        
                        while theData.containsString("[[File:") {
                            let tempArray = theData.componentsSeparatedByString("[[File:")
                            let subString = tempArray[1].componentsSeparatedByString("]]")[0] as! String
                            let removeString = "[[File:" + subString + "]]"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<ref") {
                            let tempArray = theData.componentsSeparatedByString("<ref")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] as! String
                            let removeString = "<ref" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<div") {
                            let tempArray = theData.componentsSeparatedByString("<div")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] as! String
                            let removeString = "<div" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("{|") {
                            let tempArray = theData.componentsSeparatedByString("{|")
                            let subString = tempArray[1].componentsSeparatedByString("|}")[0] as! String
                            let removeString = "{|" + subString + "|}"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<span") {
                            let tempArray = theData.componentsSeparatedByString("<span")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] as! String
                            let removeString = "<span" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("{{#") {
                            let tempArray = theData.componentsSeparatedByString("{{#")
                            let subString = tempArray[1].componentsSeparatedByString("}}")[0] as! String
                            let removeString = "{{#" + subString + "}}"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("\n\n\n") {
                            theData = theData.stringByReplacingOccurrencesOfString("\n\n\n", withString: "\n\n")
                        }
                        
                        while theData.containsString("<DynamicPageList>") {
                            let tempArray = theData.componentsSeparatedByString("<DynamicPageList>")
                            let subString = tempArray[1].componentsSeparatedByString("</DynamicPageList>")[0] as! String
                            let removeString = "<DynamicPageList>" + subString + "</DynamicPageList>"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<flashmp3>") {
                            let tempArray = theData.componentsSeparatedByString("<flashmp3>")
                            let subString = tempArray[1].componentsSeparatedByString("</flashmp3>")[0] as! String
                            let removeString = "<flashmp3>" + subString + "</flashmp3>"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        var theDataArray = theData.componentsSeparatedByString("\n") as! [NSString]
                        
                        for var i = 0; i < (theDataArray.count); i++ {
                            
                            theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                            
                            if theDataArray[i].hasPrefix("{") || theDataArray[i].hasPrefix("}") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Social=") || theDataArray[i].hasPrefix("== comments")  || theDataArray[i].hasPrefix("|titlemode=") || theDataArray[i].hasPrefix("|keywords=") || theDataArray[i].hasPrefix("|Image=") || theDataArray[i].hasPrefix("|Author=") || theDataArray[i].hasPrefix("|Type of Article=") || theDataArray[i].hasPrefix("|Topic=") || theDataArray[i].hasPrefix("|Event=")  {
                                theDataArray.removeAtIndex(i)
                                i--; continue
                            }
                            
                            if theDataArray[i] == "|-" {
                                theDataArray.removeAtIndex(i)
                                if theDataArray.count > i {
                                    theDataArray.removeAtIndex(i)
                                }
                                i--
                                continue
                            }
                            
                            if theDataArray[i].hasPrefix("|Name=") {
                                self.name = theDataArray[i].substringFromIndex(5)
                                theDataArray.removeAtIndex(i)
                                self.name = self.name.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Period=") {
                                self.period = theDataArray[i].substringFromIndex(7)
                                theDataArray.removeAtIndex(i)
                                self.period = self.period.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Location=") {
                                self.location = theDataArray[i].substringFromIndex(9)
                                theDataArray.removeAtIndex(i)
                                self.location = self.location.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Year=") {
                                self.year = theDataArray[i].substringFromIndex(5)
                                theDataArray.removeAtIndex(i)
                                self.year = self.year.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Email=") {
                                self.email = theDataArray[i].substringFromIndex(6)
                                theDataArray.removeAtIndex(i)
                                self.email = self.email.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Website=") {
                                self.website = theDataArray[i].substringFromIndex(8)
                                theDataArray.removeAtIndex(i)
                                self.website = self.website.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|title=") {
                                self.titleS = theDataArray[i].substringFromIndex(6)
                                theDataArray.removeAtIndex(i)
                                self.titleS = self.titleS.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|description=") {
                                self.descriptionS = theDataArray[i].substringFromIndex(12)
                                theDataArray.removeAtIndex(i)
                                self.descriptionS = self.descriptionS.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Birthdate=") {
                                self.birthDate = theDataArray[i].substringFromIndex(10)
                                theDataArray.removeAtIndex(i)
                                self.birthDate = self.birthDate.stringByReplacingOccurrencesOfString("=", withString: "")
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
                        
                        if self.descriptionS != "" {
                            theParagraph = "== Description ==\n" + self.descriptionS + "\n\n" + theParagraph
                        }
                        if self.titleS != "" {
                            theParagraph = "== Title ==\n" + self.titleS + "\n\n" + theParagraph
                        }
                        if self.email != "" {
                            theParagraph = "== Email ==\n" + self.email + "\n\n" + theParagraph
                        }
                        if self.website != "" {
                            theParagraph = "== Website ==\n" + self.website + "\n\n" + theParagraph
                        }
                        if self.year != "" {
                            theParagraph = "== Year ==\n" + self.year + "\n\n" + theParagraph
                        }
                        if self.location != "" {
                            theParagraph = "== Location ==\n" + self.location + "\n\n" + theParagraph
                        }
                        if self.period != "" {
                            theParagraph = "== Period ==\n" + self.period + "\n\n" + theParagraph
                        }
                        if self.name != "" {
                            theParagraph = "== Name ==\n" + self.name + "\n\n" + theParagraph
                        }
                        
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br />", withString: "\n")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</ref>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</div>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</span>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</center>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<center>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("{{DISQUS}}", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</big>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<big>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<small>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</small>", withString: "")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("{{#seo:", withString: "")
                        theParagraph = theParagraph.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                        
                        self.textView.text = theParagraph
                        
                        self.anthologyNameLabel.text = self.anthologyName
                        
                        self.textView.scrollRangeToVisible(NSRange(0...0))
                        
                        self.activityIndicator.hidesWhenStopped = true
                        
                        self.activityIndicator.stopAnimating()
                        
                    } else {
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                        self.showAlertWithText(header: "Warning", message: "This page is corrupted.  Please contact a site admin.")
                        
                    }
                }
            }
            
        })
        
        task.resume()
    
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

    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
