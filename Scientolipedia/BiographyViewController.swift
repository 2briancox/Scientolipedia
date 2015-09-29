//
//  BiographyViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/28/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class BiographyViewController: UIViewController, UIPopoverControllerDelegate {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var picutreHeight: NSLayoutConstraint!
    @IBOutlet weak var pictureTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var profileName: String = ""
    var imageName = ""
    var birthday = ""
    var birthInfo = ""
    var deceased = ""
    var diedOn = ""
    var info = ""
    var nationality = ""
    var orgAffiliation = ""
    var posts = ""
    var spouse = ""
    var children = ""
    var occupation = ""
    var trainingLevel = ""
    var website = ""
    var yearsActive = ""
    var socialMedia = ""
    var deathInfo = ""
    var caseLevel = ""
    var descriptionText = ""
    var email = ""
    
    var rightBarButtonItemAction: UIBarButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addRightNavItemOnView()
        
        self.activityIndicator.startAnimating()
        
        self.profileNameLabel.text = self.profileName
        
        var parsedProfileData: [String: AnyObject] = Dictionary<String, AnyObject>()
        
        var profileURL = profileName.stringByReplacingOccurrencesOfString(" ", withString: "_")

        profileURL = ("http://scientolipedia.org/w/api.php?action=query&titles=" + profileURL + "&prop=revisions&rvprop=content&format=json" as NSString) as String
        
        profileURL = profileURL.stringByReplacingOccurrencesOfString("_&_", withString: "_%26_")
        
        var urlNSString: NSString = profileURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        profileURL = urlNSString as String
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: profileURL)!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            if error == nil {
                
                parsedProfileData = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! [String: AnyObject]
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText("Warning", message: "This page cannot load right now. Please try again.")
                    
                } else {
                    
                    var profileJSONArray = parsedProfileData["query"] as! [String: AnyObject]

                    let this = profileJSONArray["pages"] as! NSDictionary

                    var dataForProfile = this.allValues.last as! [String: AnyObject]

                    var profilePageRevs = dataForProfile["revisions"] as! [[String: AnyObject]]

                    var completeData = profilePageRevs[0]

                    var theData: NSString = completeData["*"] as! NSString

                    theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")
                    
                    while theData.containsString("[[File:") {
                        let tempArray = theData.componentsSeparatedByString("[[File:")
                        let subString = tempArray[1].componentsSeparatedByString("]]")[0] 
                        let removeString = "[[File:" + subString + "]]"
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
                    
                    while theData.containsString("<div") {
                        let tempArray = theData.componentsSeparatedByString("<div")
                        let subString = tempArray[1].componentsSeparatedByString(">")[0] 
                        let removeString = "<div" + subString + ">"
                        theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                    }
                    
                    while theData.containsString("<DynamicPageList>") {
                        let tempArray = theData.componentsSeparatedByString("<DynamicPageList>")
                        let subString = tempArray[1].componentsSeparatedByString("</DynamicPageList>")[0] 
                        let removeString = "<DynamicPageList>" + subString + "</DynamicPageList>"
                        theData = theData.stringByReplacingOccurrencesOfString(removeString, withString: "")
                    }
                    
                    while theData.containsString("<ref") {
                        let tempArray = theData.componentsSeparatedByString("<ref")
                        let subString = tempArray[1].componentsSeparatedByString(">")[0] 
                        let removeString = "<ref" + subString + ">"
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

                        if theDataArray[i].containsString("{") || theDataArray[i].containsString("}") || theDataArray[i].containsString("<") || theDataArray[i].containsString(">") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Social=") || theDataArray[i].hasPrefix("== comments")  || theDataArray[i].hasPrefix("|titlemode=")  || theDataArray[i].hasPrefix("|keywords=") {
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
                        if theDataArray[i].hasPrefix("|Birthdate=") {
                            self.birthday = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(10))
                            theDataArray.removeAtIndex(i)
                            self.birthday = self.birthday.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Birthday=") {
                            self.birthday = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(9))
                            theDataArray.removeAtIndex(i)
                            self.birthday = self.birthday.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        
                        if theDataArray[i].hasPrefix("|Birth info=") {
                            self.birthInfo = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(12))
                            theDataArray.removeAtIndex(i)
                            self.birthInfo = self.birthInfo.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Deceased=") {
                            self.deceased = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(9))
                            theDataArray.removeAtIndex(i)
                            self.deceased = self.deceased.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Died on=") {
                            self.diedOn = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(8))
                            theDataArray.removeAtIndex(i)
                            self.diedOn = self.diedOn.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Death info=") {
                            self.deathInfo = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(11))
                            theDataArray.removeAtIndex(i)
                            self.deathInfo = self.deathInfo.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|info=") {
                            self.info = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(5))
                            theDataArray.removeAtIndex(i)
                            self.info = self.info.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Case Level=") {
                            self.caseLevel = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(11))
                            theDataArray.removeAtIndex(i)
                            self.caseLevel = self.caseLevel.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Nationality=") {
                            self.nationality = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(12))
                            theDataArray.removeAtIndex(i)
                            self.nationality = self.nationality.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Org. affiliation=") {
                            self.orgAffiliation = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(17))
                            theDataArray.removeAtIndex(i)
                            self.orgAffiliation = self.orgAffiliation.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Posts=") {
                            self.posts = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(6))
                            theDataArray.removeAtIndex(i)
                            self.posts = self.posts.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Spouse=") {
                            self.spouse = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(7))
                            theDataArray.removeAtIndex(i)
                            self.spouse = self.spouse.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Children=") {
                            self.children = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(9))
                            theDataArray.removeAtIndex(i)
                            self.children = self.children.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Occupation=") {
                            self.occupation = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(11))
                            theDataArray.removeAtIndex(i)
                            self.occupation = self.occupation.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Training Level=") {
                            self.trainingLevel = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(15))
                            theDataArray.removeAtIndex(i)
                            self.trainingLevel = self.trainingLevel.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Website=") {
                            self.website = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(8))
                            theDataArray.removeAtIndex(i)
                            self.website = self.website.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|description=") {
                            self.descriptionText = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(12))
                            theDataArray.removeAtIndex(i)
                            self.descriptionText = self.descriptionText.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Years active=") {
                            self.yearsActive = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(13))
                            theDataArray.removeAtIndex(i)
                            self.yearsActive = self.yearsActive.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Social Media=") {
                            self.socialMedia = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(13))
                            theDataArray.removeAtIndex(i)
                            self.socialMedia = self.socialMedia.stringByReplacingOccurrencesOfString("=", withString: "")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Image=") {
                            self.imageName = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(7))
                            theDataArray.removeAtIndex(i)
                            self.imageName = self.imageName.stringByReplacingOccurrencesOfString("=", withString: "")
                            self.imageName = self.imageName.stringByReplacingOccurrencesOfString(" ", withString: "_")
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Email=") {
                            self.email = theDataArray[i].substringFromIndex(theDataArray[i].startIndex.advancedBy(7))
                            theDataArray.removeAtIndex(i)
                            self.email = self.email.stringByReplacingOccurrencesOfString("=", withString: "")
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
                    if self.descriptionText != "" {
                        theParagraph = "== Description ==\n" + self.descriptionText + "\n\n" + theParagraph
                    }
                    if self.socialMedia != "" {
                        theParagraph = "== Social Media ==\n" + self.socialMedia + "\n\n" + theParagraph
                    }
                    if self.yearsActive != "" {
                        theParagraph = "== Years Active ==\n" + self.yearsActive + "\n\n" + theParagraph
                    }
                    if self.email != "" {
                        theParagraph = "== Email Address ==\n" + self.email + "\n\n" + theParagraph
                    }
                    if self.website != "" {
                        theParagraph = "== Website ==\n" + self.website + "\n\n" + theParagraph
                    }
                    if self.trainingLevel != "" {
                        theParagraph = "== Training Level ==\n" + self.trainingLevel + "\n\n" + theParagraph
                    }
                    if self.occupation != "" {
                        theParagraph = "== Occupation ==\n" + self.occupation + "\n\n" + theParagraph
                    }
                    if self.children != "" {
                        theParagraph = "== Children ==\n" + self.children + "\n\n" + theParagraph
                    }
                    if self.spouse != "" {
                        theParagraph = "== Spouse ==\n" + self.spouse + "\n\n" + theParagraph
                    }
                    if self.posts != "" {
                        theParagraph = "== Posts ==\n" + self.posts + "\n\n" + theParagraph
                    }
                    if self.orgAffiliation != "" {
                        theParagraph = "== Org Affiliation ==\n" + self.orgAffiliation + "\n\n" + theParagraph
                    }
                    if self.nationality != "" {
                        theParagraph = "== Nationality ==\n" + self.nationality + "\n\n" + theParagraph
                    }
                    if self.info != "" {
                        theParagraph = "== Information ==\n" + self.info + "\n\n" + theParagraph
                    }
                    if self.diedOn != "" {
                        theParagraph = "== Died on: ==\n" + self.diedOn + "\n\n" + theParagraph
                    }
                    if self.deceased != "" {
                        theParagraph = "== Deceased? ==\n" + self.deceased + "\n\n" + theParagraph
                    }
                    if self.birthInfo != "" {
                        theParagraph = "== Birth Information ==\n" + self.birthInfo + "\n\n" + theParagraph
                    }
                    if self.birthday != "" {
                        theParagraph = "== Birthday ==\n" + self.birthday + "\n\n" + theParagraph
                    }
                    if self.deathInfo != "" {
                        theParagraph = "== Death Information ==\n" + self.deathInfo + "\n\n" + theParagraph
                    }
                    if self.caseLevel != "" {
                        theParagraph = "== Case Level ==\n" + self.caseLevel + "\n\n" + theParagraph
                    }

                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br />", withString: "\n")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
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
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("{{#seo:", withString: "")
                    theParagraph = theParagraph.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    
                    self.textView.text = theParagraph
                    
                    if self.imageName != "" {
                        if let imageData = NSData(contentsOfURL: NSURL(string: showPic(self.imageName as String))!) {
                            self.profileImage.image = UIImage(data: imageData)
                        } else {
                            self.picutreHeight.setValue(CGFloat(0.0), forKey: "constant")
                            self.pictureTopSpace.setValue(CGFloat(0.0), forKey: "constant")
                            self.profileImage.hidden = true
                        }
                    } else {
                        self.picutreHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.pictureTopSpace.setValue(CGFloat(0.0), forKey: "constant")
                        self.profileImage.hidden = true
                    }
                    
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.stopAnimating()
                    
                    self.textView.scrollRangeToVisible(NSRange(0...0))
                }
            }
            
        })
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func openPageButtonPressed(sender: UIButton) {
        var profileURL = profileName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        profileURL = ("http://scientolipedia.org/info/" + profileURL as NSString) as String
        
        var urlNSString: NSString = profileURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        profileURL = urlNSString as String
        
        UIApplication.sharedApplication().openURL(NSURL(string:profileURL)!)
        
    }


    func showAlertWithText (header : String = "Warning", message : String) {
            let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
    }


    override func shouldAutorotate() -> Bool {
        return false
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

    func sendPagePressed(sender: AnyObject) {
        
        var profileURL = profileName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        profileURL = "http://scientolipedia.org/info/" + profileURL
        
        var urlNSString: NSString = profileURL as NSString
        
        urlNSString = urlNSString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        profileURL = urlNSString as String

        let pageInfo = [("~ " + profileName + " ~\n\n" + textView.text! + "\n\n Sent from the Scientolipedia iOS App.\nThis page can be found at:\n\n" + profileURL) as String]
        
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