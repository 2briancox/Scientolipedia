//
//  AuditorPageViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/6/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class AuditorPageViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var theAuditor: AuditorModel!
    
    var auditorImage = ""
    var auditorLevel = ""
    var auditorCaseSup = ""
    var auditorCase = ""
    var auditorCountry = ""
    var auditorCity = ""
    var auditorPostalCode = ""
    var auditorGEO = ""
    var auditorWebsite = ""
    var auditorEmail = ""
    var auditorState = ""
    var auditorName = ""
    var auditorSocial = ""
    var auditorTrainOffer = ""
    var auditorAuditOffer = ""
    var auditorPhone = ""
    var auditorSkype = ""
    var auditorEvent = ""
    var auditorEventInfo = ""
    var auditorDescription = ""
    
    @IBOutlet weak var auditorNameLabel: UILabel!
    @IBOutlet weak var auditorImageView: UIImageView!
    @IBOutlet weak var auditorParagraphText: UITextView!
    @IBOutlet weak var auditorLevelLabel: UILabel!
    @IBOutlet weak var auditorCSLabel: UILabel!
    @IBOutlet weak var auditorCaseLabel: UILabel!
    @IBOutlet weak var auditorCountryLabel: UILabel!
    @IBOutlet weak var auditorStateLabel: UILabel!
    @IBOutlet weak var auditorCityLabel: UILabel!
    
    @IBOutlet weak var phoneButtonLabel: UIButton!
    
    @IBOutlet weak var emailButtonLabel: UIButton!
    
    @IBOutlet weak var websiteButtonLabel: UIButton!
    
    @IBOutlet weak var phoneButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var websiteButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var emailButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var csLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cityLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stateLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var countryLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var caseLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var levelLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var websiteBottom: NSLayoutConstraint!
    
    @IBOutlet weak var emailBottom: NSLayoutConstraint!
    
    @IBOutlet weak var phoneBottom: NSLayoutConstraint!
    
    @IBOutlet weak var cityBottom: NSLayoutConstraint!
    
    @IBOutlet weak var stateBottom: NSLayoutConstraint!
    
    @IBOutlet weak var countryBottom: NSLayoutConstraint!
    
    @IBOutlet weak var caseBottom: NSLayoutConstraint!
    
    @IBOutlet weak var csBottom: NSLayoutConstraint!
    
    @IBOutlet weak var levelBottom: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        
        var parsingAuditorError: NSError? = nil
        // Do any additional setup after loading the view
        let BASE_URL = "http://scientolipedia.org/w/"
        
        let urlName = theAuditor.name.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        let theAuditorJSONURL = (BASE_URL + "api.php?action=query&titles=" + urlName + "&prop=revisions&rvprop=content&format=json").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let pathForJSON = NSURL(string: theAuditorJSONURL!)
        var parsedJSON: [String: AnyObject] = Dictionary<String, AnyObject>()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(pathForJSON!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            if error == nil {
              
                let auditorJSON = data
        
                parsedJSON = NSJSONSerialization.JSONObjectWithData(auditorJSON!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                 if urlError == true {
                
                     self.showAlertWithText(header: "Warning", message: "This page cannot load right now. Please try again later.")
                
                 } else {
                    
                    var auditorJSONArray = parsedJSON["query"] as! [String: AnyObject]
                    
                    var this = auditorJSONArray["pages"] as! NSDictionary
                    
                    var dataForAuditor = this.allValues.last as! [String: AnyObject]
                    
                    var auditorPageRevs = dataForAuditor["revisions"] as! [[String: AnyObject]]
                    
                    var completeData = auditorPageRevs[0]
                    
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
                        if theDataArray[i].containsString("{") || theDataArray[i].containsString("}") || theDataArray[i].containsString("<") || theDataArray[i].containsString(">") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("width: ") || theDataArray[i].hasPrefix("height: ") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Year=") || theDataArray[i].hasPrefix("|Intro=") || theDataArray[i].hasPrefix("|LR=") || theDataArray[i].hasPrefix("|Grades=") || theDataArray[i].hasPrefix("|WDAH=") || theDataArray[i].hasPrefix("|keywords=") || theDataArray[i].hasPrefix("|Purif=") || theDataArray[i].hasPrefix("|Clears=") || theDataArray[i].hasPrefix("|OTs=") || theDataArray[i].hasPrefix("|Basic Courses=") || theDataArray[i].hasPrefix("|St Hat=") || theDataArray[i].hasPrefix("|Levels=") || theDataArray[i].hasPrefix("|Internships=") || theDataArray[i].hasPrefix("|Solo Crse=") {
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
                        
                        if theDataArray[i].hasPrefix("|Auditing Delivery=") {
                            self.auditorAuditOffer = theDataArray[i].substringFromIndex(19)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Training Offered=") {
                            self.auditorTrainOffer = theDataArray[i].substringFromIndex(18)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Auditing Offered=") {
                            self.auditorAuditOffer = theDataArray[i].substringFromIndex(18)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Case Supervision=") {
                            self.auditorCaseSup = theDataArray[i].substringFromIndex(18)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Primary Contact=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Training Level=") {
                            self.auditorLevel = theDataArray[i].substringFromIndex(16)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Social Media=") {
                            self.auditorSocial = theDataArray[i].substringFromIndex(14)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Postal Code=") {
                            self.auditorPostalCode = theDataArray[i].substringFromIndex(13)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|searchlabel=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Event Info=") {
                            self.auditorEventInfo = theDataArray[i].substringFromIndex(12)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Case Level=") {
                            self.auditorCase = theDataArray[i].substringFromIndex(12)
                            if self.auditorCase.hasPrefix("Original") {
                                self.auditorCase = (self.auditorCase as NSString).substringFromIndex(8)
                            }
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|mainlabel=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|titlemode=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Country=") {
                            self.auditorCountry = theDataArray[i].substringFromIndex(9)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Website=") {
                            self.auditorWebsite = theDataArray[i].substringFromIndex(9)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|headers=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|format=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Image=") {
                            self.auditorImage = theDataArray[i].substringFromIndex(7)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Email=") {
                            self.auditorEmail = theDataArray[i].substringFromIndex(7)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|State=") {
                            self.auditorState = theDataArray[i].substringFromIndex(7)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Phone=") {
                            self.auditorPhone = theDataArray[i].substringFromIndex(7)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Skype=") {
                            self.auditorSkype = theDataArray[i].substringFromIndex(7)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|limit=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|title=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|class=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Event=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|City=") {
                            self.auditorCity = theDataArray[i].substringFromIndex(6)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Name=") {
                            self.auditorName = theDataArray[i].substringFromIndex(6)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|link=") {
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|Geo=") {
                            self.auditorGEO = theDataArray[i].substringFromIndex(5)
                            theDataArray.removeAtIndex(i)
                            i--; continue
                        }
                        if theDataArray[i].hasPrefix("|description=") {
                            self.auditorDescription = theDataArray[i].substringFromIndex(13)
                            theDataArray.removeAtIndex(i)
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
                            
                            theParagraph = theParagraph + "\n"
                        }
                    }
                    
                    if self.auditorTrainOffer != "" {
                        theParagraph += "\n\n== Training Offered ==\n" + self.auditorTrainOffer
                    }
                    
                    if self.auditorAuditOffer != "" {
                        theParagraph += "\n\n== Auditing Offered ==\n" + self.auditorAuditOffer
                    }
                    
                    if self.auditorSocial != "" {
                        theParagraph += "\n\n== Social ==\n" + self.auditorSocial
                    }
                    
                    if self.auditorSkype != "" {
                        theParagraph += "\n== Skype ==\n" + self.auditorSkype
                    }
                    
                    if self.auditorDescription != "" {
                        theParagraph += "\n\n== Description ==\n" + self.auditorDescription
                    }

                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br />", withString: "\n")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</div>", withString: "")
                    theParagraph = theParagraph.stringByReplacingOccurrencesOfString("</ref>", withString: "")
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

                    while (theParagraph as NSString).containsString("\n\n\n") {
                        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("\n\n\n", withString: "\n\n")
                    }

                    self.auditorParagraphText.text = theParagraph
                    
                    self.auditorNameLabel.text = self.theAuditor.name
                    
                    if self.auditorLevel != "" {
                        self.auditorLevelLabel.text = "Lvl:" + self.auditorLevel
                    } else {
                        self.levelLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.levelBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorCaseSup != "" {
                        self.auditorCSLabel.text = "CS:" + self.auditorCaseSup
                    } else {
                        self.csLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.csBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorCase != "" {
                        self.auditorCaseLabel.text = "Case:" + self.auditorCase
                    } else {
                        self.caseLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.caseBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorCountry != "" {
                        self.auditorCountryLabel.text = self.auditorCountry
                    } else {
                        self.countryLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.countryBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorState != "" {
                        self.auditorStateLabel.text = self.auditorState
                    } else {
                        self.stateLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.stateBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorCity != "" {
                        self.auditorCityLabel.text = self.auditorCity
                    } else {
                        self.cityLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.cityBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorImage != "" {
                        var imageURL = NSURL(string: showPic(self.auditorImage as String))
                        var imageData = NSData(contentsOfURL: imageURL!)
                        self.auditorImageView.image = UIImage(data: imageData!)
                    } else {
                        self.imageViewHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.imageViewWidth.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorPhone != "" {
                        self.phoneButtonLabel.setTitle(self.auditorPhone, forState: UIControlState.Normal)
                    } else {
                        self.phoneButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.phoneButtonLabel.hidden = true
                        self.phoneBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorEmail != "" {
                        self.emailButtonLabel.setTitle(self.auditorEmail, forState: UIControlState.Normal)
                    } else {
                        self.emailButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.emailButtonLabel.hidden = true
                        self.emailBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    if self.auditorWebsite != "" {
                        self.websiteButtonLabel.setTitle(self.auditorWebsite, forState: UIControlState.Normal)
                    } else {
                        self.websiteButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
                        self.websiteButtonLabel.hidden = true
                        self.websiteBottom.setValue(CGFloat(0.0), forKey: "constant")
                    }
                    
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.stopAnimating()
                }
            }
            
        })
        
        task.resume()

        self.auditorParagraphText.scrollRangeToVisible(NSRange(0...0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func phoneButtonPressed(sender: UIButton) {
        var phoneNumber = auditorPhone.stringByReplacingOccurrencesOfString(" ", withString: "")
        phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("-", withString: "")
        phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("(", withString: "")
        phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString(")", withString: "")
        phoneNumber = phoneNumber.stringByReplacingOccurrencesOfString("+", withString: "")
        phoneNumber = "tel:" + phoneNumber
        
        let address = NSURL(string: phoneNumber)
        UIApplication.sharedApplication().openURL(address!)
    }
    
    @IBAction func emailButtonPressed(sender: UIButton) {
        let messageBody: NSString = "== This message was sent through the Scientolipedia phone app. ==\n\n"
        let toRecipients: NSArray = NSArray(array: [auditorEmail])
        var mailComposer: MFMailComposeViewController = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(toRecipients as [AnyObject])
        mailComposer.setMessageBody(messageBody as String, isHTML: false)
        self.presentViewController(mailComposer, animated: true, completion: nil)
    }
    
    @IBAction func websiteButtonPressed(sender: UIButton) {
        var address = NSURL(string: auditorWebsite)
        UIApplication.sharedApplication().openURL(address!)
    }
    
    
    @IBAction func openPageButtonPressed(sender: UIBarButtonItem) {
        var auditorURL = theAuditor.name.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        auditorURL = ("http://scientolipedia.org/info/" + auditorURL as NSString) as String
        
        auditorURL = auditorURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        UIApplication.sharedApplication().openURL(NSURL(string:auditorURL)!)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
