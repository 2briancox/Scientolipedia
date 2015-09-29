//
//  AnthologyViewController.swift
//  Scientolipedia
//
//  Created by Brian on 6/5/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class AnthologyViewController: UIViewController, UIPopoverControllerDelegate {

    @IBOutlet weak var anthologyNameLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
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
    var rightBarButtonItemAction: UIBarButtonItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.addRightNavItemOnView()
        
        self.activityIndicator.startAnimating()
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        var parsedAnthologyData: [String: AnyObject] = Dictionary<String, AnyObject>()
        
        anthologyURL  = "http://scientolipedia.org/w/api.php?action=query&titles=" + anthologyURL + "&prop=revisions&rvprop=content&format=json"

        anthologyURL = anthologyURL.stringByReplacingOccurrencesOfString("_&_", withString: "_%26_")

        var urlNSString: NSString = anthologyURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        anthologyURL = urlNSString as String
        anthologyURL = anthologyURL.stringByReplacingOccurrencesOfString("_%2526_", withString: "_%26_")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: anthologyURL)!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            if error == nil {
                
                parsedAnthologyData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! [String: AnyObject]
                
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText("Warning", message: "This page cannot load right now. Please try again.")
                    
                } else {
                    var anthologyJSONArray = parsedAnthologyData["query"] as! [String: AnyObject]
                    
                    let this = anthologyJSONArray["pages"] as! NSDictionary
                    
                    var dataForAnthology = this.allValues.last as! [String: AnyObject]
                    
                    var goodToGo = false
                    
                    for key in Array(dataForAnthology.keys) {
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
                            let subString = tempArray[1].componentsSeparatedByString("]]")[0] 
                            let removeString = "[[File:" + subString + "]]"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<ref") {
                            let tempArray = theData.componentsSeparatedByString("<ref")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] 
                            let removeString = "<ref" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<div") {
                            let tempArray = theData.componentsSeparatedByString("<div")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] 
                            let removeString = "<div" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("{|") {
                            let tempArray = theData.componentsSeparatedByString("{|")
                            let subString = tempArray[1].componentsSeparatedByString("|}")[0] 
                            let removeString = "{|" + subString + "|}"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<span") {
                            let tempArray = theData.componentsSeparatedByString("<span")
                            let subString = tempArray[1].componentsSeparatedByString(">")[0] 
                            let removeString = "<span" + subString + ">"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("{{#") {
                            let tempArray = theData.componentsSeparatedByString("{{#")
                            let subString = tempArray[1].componentsSeparatedByString("}}")[0] 
                            let removeString = "{{#" + subString + "}}"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("\n\n\n") {
                            theData = theData.stringByReplacingOccurrencesOfString("\n\n\n", withString: "\n\n")
                        }
                        
                        while theData.containsString("<DynamicPageList>") {
                            let tempArray = theData.componentsSeparatedByString("<DynamicPageList>")
                            let subString = tempArray[1].componentsSeparatedByString("</DynamicPageList>")[0] 
                            let removeString = "<DynamicPageList>" + subString + "</DynamicPageList>"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        while theData.containsString("<flashmp3>") {
                            let tempArray = theData.componentsSeparatedByString("<flashmp3>")
                            let subString = tempArray[1].componentsSeparatedByString("</flashmp3>")[0] 
                            let removeString = "<flashmp3>" + subString + "</flashmp3>"
                            theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                        }
                        
                        var theDataArray = theData.componentsSeparatedByString("\n")
                        
                        for var i = 0; i < (theDataArray.count); i++ {
                            
                            theDataArray[i] = theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
                            
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
                                self.name = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(5))
                                theDataArray.removeAtIndex(i)
                                self.name = self.name.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Period=") {
                                self.period = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(7))
                                theDataArray.removeAtIndex(i)
                                self.period = self.period.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Location=") {
                                self.location = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(9))
                                theDataArray.removeAtIndex(i)
                                self.location = self.location.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Year=") {
                                self.year = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(5))
                                theDataArray.removeAtIndex(i)
                                self.year = self.year.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Email=") {
                                self.email = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(6))
                                theDataArray.removeAtIndex(i)
                                self.email = self.email.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Website=") {
                                self.website = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(8))
                                theDataArray.removeAtIndex(i)
                                self.website = self.website.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|title=") {
                                self.titleS = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(6))
                                theDataArray.removeAtIndex(i)
                                self.titleS = self.titleS.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|description=") {
                                self.descriptionS = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(12))
                                theDataArray.removeAtIndex(i)
                                self.descriptionS = self.descriptionS.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                            if theDataArray[i].hasPrefix("|Birthdate=") {
                                self.birthDate = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(10))
                                theDataArray.removeAtIndex(i)
                                self.birthDate = self.birthDate.stringByReplacingOccurrencesOfString("=", withString: "")
                                i--; continue
                            }
                        }
                        
                        var theParagraph = ""
                        
                        for var i = 0; i < theDataArray.count; i++ {
                            if theDataArray[i].substringToIndex(theDataArray[i].startIndex.successor()) == "=" {
                                theParagraph += "\n\n"
                            }
                            theParagraph = theParagraph + (theDataArray[i] as String) + " "
                            if theDataArray[i].substringFromIndex(theDataArray[i].endIndex.predecessor())  == "=" || theDataArray[i].substringFromIndex(theDataArray[i].endIndex.predecessor())  == ":" {
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
                        
                        self.showAlertWithText("Warning", message: "This page is corrupted.  Please contact a site admin.")
                        
                    }
                }
            }
            
        })
        
        task.resume()
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func openPageButtonPressed(sender: UIBarButtonItem) {
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = ("http://scientolipedia.org/info/" + anthologyURL as NSString) as String
        
        var urlNSString: NSString = anthologyURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        anthologyURL = urlNSString as String
        
        UIApplication.sharedApplication().openURL(NSURL(string:anthologyURL)!)
        
    }

    func addRightNavItemOnView()
    {
        
        let buttonBrowse: UIButton = UIButton(type: UIButtonType.Custom)
        buttonBrowse.frame = CGRectMake(0, 0, 40, 40)
        buttonBrowse.setImage(UIImage(named:"browser"), forState: UIControlState.Normal)
        buttonBrowse.addTarget(self, action: "openPageButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemBrowse: UIBarButtonItem = UIBarButtonItem(customView: buttonBrowse)
        
        let buttonAction: UIButton = UIButton(type: UIButtonType.Custom)
        buttonAction.frame = CGRectMake(0, 0, 40, 40)
        buttonAction.setImage(UIImage(named:"actionButton"), forState: UIControlState.Normal)
        buttonAction.addTarget(self, action: "sendPagePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.rightBarButtonItemAction = UIBarButtonItem(customView: buttonAction)
        
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemAction, rightBarButtonItemBrowse], animated: true)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func sendPagePressed(sender: AnyObject) {
        
        var anthologyURL = anthologyName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        anthologyURL = "http://scientolipedia.org/info/" + anthologyURL
     
        var urlNSString: NSString = anthologyURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        anthologyURL = urlNSString as String
        
        let pageInfo = [("~ " + anthologyName + " ~\n\n" + textView.text! + "\n\n Sent from the Scientolipedia iOS App.\nThis page can be found at:\n\n" + anthologyURL) as String]
        
        let nextController = UIActivityViewController(activityItems: pageInfo, applicationActivities: nil)
        
        let deviceName = (UIDevice.currentDevice().modelName as NSString).substringToIndex(4)
        
        print("~" + deviceName + "~")
        
        if deviceName == "iPad" {
            let popover = UIPopoverController(contentViewController: nextController)
            popover.delegate = self
            popover.presentPopoverFromBarButtonItem(self.rightBarButtonItemAction, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        } else {
            self.presentViewController(nextController, animated: true, completion: nil)
        }
        
    }

}
