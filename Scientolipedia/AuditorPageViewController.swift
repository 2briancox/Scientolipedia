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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parsingAuditorError: NSError? = nil
        // Do any additional setup after loading the view
        let BASE_URL = "http://scientolipedia.org/w/"
        
        let urlName = theAuditor.name.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        let theAuditorJSONURL = (BASE_URL + "api.php?action=query&titles=" + urlName + "&prop=revisions&rvprop=content&format=json").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let pathForJSON = NSURL(string: theAuditorJSONURL!)
    
        let auditorJSON = NSData(contentsOfURL: pathForJSON!, options: nil, error: nil)
        
        var parsedJSON = NSJSONSerialization.JSONObjectWithData(auditorJSON!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
        
        var auditorJSONArray = parsedJSON["query"] as! [String: AnyObject]
        
        var this = auditorJSONArray["pages"] as! NSDictionary
        
        var dataForAuditor = this.allValues.last as! [String: AnyObject]
        
        var auditorPageRevs = dataForAuditor["revisions"] as! [[String: AnyObject]]
        
        var completeData = auditorPageRevs[0]
        
        var theData: NSString = completeData["*"] as! NSString
        
        theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")
        
        var theDataArray = theData.componentsSeparatedByString("\n") as! [NSString]
        
        for var i = 0; i < (theDataArray.count); i++ {
            theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            if theDataArray[i].containsString("{") || theDataArray[i].containsString("}") || theDataArray[i].containsString("<") || theDataArray[i].containsString(">") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("width: ") || theDataArray[i].hasPrefix("height: ") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Year=") || theDataArray[i].hasPrefix("|Intro=") || theDataArray[i].hasPrefix("|LR=") || theDataArray[i].hasPrefix("|Grades=") || theDataArray[i].hasPrefix("|WDAH=") || theDataArray[i].hasPrefix("|keywords=") || theDataArray[i].hasPrefix("|Purif=") || theDataArray[i].hasPrefix("|Clears=") || theDataArray[i].hasPrefix("|OTs=") || theDataArray[i].hasPrefix("|Basic Courses=") || theDataArray[i].hasPrefix("|St Hat=") || theDataArray[i].hasPrefix("|Levels=") || theDataArray[i].hasPrefix("|Internships=") || theDataArray[i].hasPrefix("|Solo Crse=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Auditing Delivery=") {
                auditorAuditOffer = theDataArray[i].substringFromIndex(19)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Training Offered=") {
                auditorTrainOffer = theDataArray[i].substringFromIndex(18)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Auditing Offered=") {
                auditorAuditOffer = theDataArray[i].substringFromIndex(18)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Case Supervision=") {
                auditorCaseSup = theDataArray[i].substringFromIndex(18)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Primary Contact=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Training Level=") {
                auditorLevel = theDataArray[i].substringFromIndex(16)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Social Media=") {
                auditorSocial = theDataArray[i].substringFromIndex(14)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Postal Code=") {
                auditorPostalCode = theDataArray[i].substringFromIndex(13)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|searchlabel=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Event Info=") {
                auditorEventInfo = theDataArray[i].substringFromIndex(12)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Case Level=") {
                auditorCase = theDataArray[i].substringFromIndex(12)
                if auditorCase.hasPrefix("Original") {
                    auditorCase = (auditorCase as NSString).substringFromIndex(8)
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
                auditorCountry = theDataArray[i].substringFromIndex(9)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Website=") {
                auditorWebsite = theDataArray[i].substringFromIndex(9)
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
                auditorImage = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Email=") {
                auditorEmail = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|State=") {
                auditorState = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Phone=") {
                auditorPhone = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Skype=") {
                auditorSkype = theDataArray[i].substringFromIndex(7)
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
                auditorCity = theDataArray[i].substringFromIndex(6)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Name=") {
                auditorName = theDataArray[i].substringFromIndex(6)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|link=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Geo=") {
                auditorGEO = theDataArray[i].substringFromIndex(5)
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|description=") {
                auditorDescription = theDataArray[i].substringFromIndex(13)
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
                theParagraph += "\n"
            }
        }
        
        if auditorTrainOffer != "" {
            theParagraph += "\n\n== Training Offered ==\n" + auditorTrainOffer
        }
        
        if auditorAuditOffer != "" {
            theParagraph += "\n\n== Auditing Offered ==\n" + auditorAuditOffer
        }
        
        if auditorSocial != "" {
            theParagraph += "\n\n== Social ==\n" + auditorSocial
        }
        
        if auditorSkype != "" {
            theParagraph += "\n== Skype ==\n" + auditorSkype
        }
        
        if auditorDescription != "" {
            theParagraph += "\n\n== Description ==\n" + auditorDescription
        }
        
        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
//        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("]", withString: "")
//        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[", withString: "")
        
        auditorParagraphText.text = theParagraph
        
        auditorNameLabel.text = theAuditor.name
        
        if auditorLevel != "" {
            auditorLevelLabel.text = "Lvl:" + auditorLevel
        } else {
            levelLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            levelBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorCaseSup != "" {
            auditorCSLabel.text = "CS:" + auditorCaseSup
        } else {
            csLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            csBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorCase != "" {
            auditorCaseLabel.text = "Case:" + auditorCase
        } else {
            caseLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            caseBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorCountry != "" {
            auditorCountryLabel.text = auditorCountry
        } else {
            countryLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            countryBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorState != "" {
            auditorStateLabel.text = auditorState
        } else {
            stateLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            stateBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorCity != "" {
            auditorCityLabel.text = auditorCity
        } else {
            cityLabelHeight.setValue(CGFloat(0.0), forKey: "constant")
            cityBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorImage != "" {
            var imageURL = NSURL(string: showPic(auditorImage))
            var imageData = NSData(contentsOfURL: imageURL!)
            auditorImageView.image = UIImage(data: imageData!)
        } else {
            imageViewHeight.setValue(CGFloat(0.0), forKey: "constant")
            imageViewWidth.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorPhone != "" {
            phoneButtonLabel.setTitle(auditorPhone, forState: UIControlState.Normal)
        } else {
            phoneButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
            phoneButtonHeight.setValue(CGFloat(0.0), forKey: "multiplier")
            phoneButtonLabel.hidden = true
            phoneBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorEmail != "" {
            emailButtonLabel.setTitle(auditorEmail, forState: UIControlState.Normal)
        } else {
            emailButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
            emailButtonHeight.setValue(CGFloat(0.0), forKey: "multiplier")
            emailButtonLabel.hidden = true
            emailBottom.setValue(CGFloat(0.0), forKey: "constant")
        }
        
        if auditorWebsite != "" {
            websiteButtonLabel.setTitle(auditorWebsite, forState: UIControlState.Normal)
        } else {
            websiteButtonHeight.setValue(CGFloat(0.0), forKey: "constant")
            websiteButtonHeight.setValue(CGFloat(0.0), forKey: "multiplier")
            websiteButtonLabel.hidden = true
            websiteBottom.setValue(CGFloat(0.0), forKey: "constant")
        }

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

}
