//
//  BiographyViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/28/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class BiographyViewController: UIViewController {
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var picutreHeight: NSLayoutConstraint!
    @IBOutlet weak var pictureTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        var profileURL = profileName.stringByReplacingOccurrencesOfString(" ", withString: "_")

        profileURL = ("http://scientolipedia.org/w/api.php?action=query&titles=" + profileURL + "&prop=revisions&rvprop=content&format=json" as NSString) as String

        profileURL = profileURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        let pageURL = NSURL(string: profileURL)

        var parsingProfileError: NSError? = nil

        let profileJSONData = NSData(contentsOfURL: pageURL!)

        var parsedProfileData = NSJSONSerialization.JSONObjectWithData(profileJSONData!, options: .AllowFragments, error: &parsingProfileError) as! [String: AnyObject]

        var profileJSONArray = parsedProfileData["query"] as! [String: AnyObject]

        var this = profileJSONArray["pages"] as! NSDictionary

        var dataForProfile = this.allValues.last as! [String: AnyObject]

        var profilePageRevs = dataForProfile["revisions"] as! [[String: AnyObject]]

        var completeData = profilePageRevs[0]

        var theData: NSString = completeData["*"] as! NSString

        println(theData)

        theData = theData.stringByReplacingOccurrencesOfString("\n\n", withString: "%%%%%")

        var theDataArray = theData.componentsSeparatedByString("\n") as! [NSString]

        for var i = 0; i < (theDataArray.count); i++ {

            theDataArray[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())

            if theDataArray[i].containsString("{") || theDataArray[i].containsString("}") || theDataArray[i].containsString("<") || theDataArray[i].containsString(">") || theDataArray[i].containsString("__") || theDataArray[i].hasPrefix("[[Category:") || theDataArray[i].hasPrefix("[[File:") || theDataArray[i] == "" || theDataArray[i] == "-" || theDataArray[i] == " " || theDataArray[i].hasPrefix("|Social=") || theDataArray[i].hasPrefix("== comments")  || theDataArray[i].hasPrefix("|titlemode=")  || theDataArray[i].hasPrefix("|keywords=") {
                theDataArray.removeAtIndex(i)
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Birthday=") {
                birthday = theDataArray[i].substringFromIndex(9)
                theDataArray.removeAtIndex(i)
                birthday = birthday.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Birth info=") {
                birthInfo = theDataArray[i].substringFromIndex(12)
                theDataArray.removeAtIndex(i)
                birthInfo = birthInfo.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Deceased=") {
                deceased = theDataArray[i].substringFromIndex(9)
                theDataArray.removeAtIndex(i)
                deceased = deceased.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Died on=") {
                diedOn = theDataArray[i].substringFromIndex(8)
                theDataArray.removeAtIndex(i)
                diedOn = diedOn.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Death info=") {
                deathInfo = theDataArray[i].substringFromIndex(11)
                theDataArray.removeAtIndex(i)
                deathInfo = deathInfo.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|info=") {
                info = theDataArray[i].substringFromIndex(5)
                theDataArray.removeAtIndex(i)
                info = info.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Case Level=") {
                caseLevel = theDataArray[i].substringFromIndex(11)
                theDataArray.removeAtIndex(i)
                caseLevel = caseLevel.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Nationality=") {
                nationality = theDataArray[i].substringFromIndex(12)
                theDataArray.removeAtIndex(i)
                nationality = nationality.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Org. affiliation=") {
                orgAffiliation = theDataArray[i].substringFromIndex(17)
                theDataArray.removeAtIndex(i)
                orgAffiliation = orgAffiliation.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Posts=") {
                posts = theDataArray[i].substringFromIndex(6)
                theDataArray.removeAtIndex(i)
                posts = posts.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Spouse=") {
                spouse = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                spouse = spouse.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Children=") {
                children = theDataArray[i].substringFromIndex(9)
                theDataArray.removeAtIndex(i)
                children = children.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Occupation=") {
                occupation = theDataArray[i].substringFromIndex(11)
                theDataArray.removeAtIndex(i)
                occupation = occupation.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Training Level=") {
                trainingLevel = theDataArray[i].substringFromIndex(15)
                theDataArray.removeAtIndex(i)
                trainingLevel = trainingLevel.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Website=") {
                website = theDataArray[i].substringFromIndex(8)
                theDataArray.removeAtIndex(i)
                website = website.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|description=") {
                descriptionText = theDataArray[i].substringFromIndex(12)
                theDataArray.removeAtIndex(i)
                descriptionText = descriptionText.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Years active=") {
                yearsActive = theDataArray[i].substringFromIndex(13)
                theDataArray.removeAtIndex(i)
                yearsActive = yearsActive.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Social Media=") {
                socialMedia = theDataArray[i].substringFromIndex(13)
                theDataArray.removeAtIndex(i)
                socialMedia = socialMedia.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Image=") {
                imageName = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                imageName = imageName.stringByReplacingOccurrencesOfString("=", withString: "")
                i--; continue
            }
            if theDataArray[i].hasPrefix("|Email=") {
                email = theDataArray[i].substringFromIndex(7)
                theDataArray.removeAtIndex(i)
                email = email.stringByReplacingOccurrencesOfString("=", withString: "")
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
        if descriptionText != "" {
            theParagraph = "== Description ==\n" + descriptionText + "\n\n" + theParagraph
        }
        if socialMedia != "" {
            theParagraph = "== Social Media ==\n" + socialMedia + "\n\n" + theParagraph
        }
        if yearsActive != "" {
            theParagraph = "== Years Active ==\n" + yearsActive + "\n\n" + theParagraph
        }
        if email != "" {
            theParagraph = "== Email Address ==\n" + email + "\n\n" + theParagraph
        }
        if website != "" {
            theParagraph = "== Website ==\n" + website + "\n\n" + theParagraph
        }
        if trainingLevel != "" {
            theParagraph = "== Training Level ==\n" + trainingLevel + "\n\n" + theParagraph
        }
        if occupation != "" {
            theParagraph = "== Occupation ==\n" + occupation + "\n\n" + theParagraph
        }
        if children != "" {
            theParagraph = "== Children ==\n" + children + "\n\n" + theParagraph
        }
        if spouse != "" {
            theParagraph = "== Spouse ==\n" + spouse + "\n\n" + theParagraph
        }
        if posts != "" {
            theParagraph = "== Posts ==\n" + posts + "\n\n" + theParagraph
        }
        if orgAffiliation != "" {
            theParagraph = "== Org Affiliation ==\n" + orgAffiliation + "\n\n" + theParagraph
        }
        if nationality != "" {
            theParagraph = "== Nationality ==\n" + nationality + "\n\n" + theParagraph
        }
        if info != "" {
            theParagraph = "== Information ==\n" + info + "\n\n" + theParagraph
        }
        if diedOn != "" {
            theParagraph = "== Died on: ==\n" + diedOn + "\n\n" + theParagraph
        }
        if deceased != "" {
            theParagraph = "== Deceased? ==\n" + deceased + "\n\n" + theParagraph
        }
        if birthInfo != "" {
            theParagraph = "== Birth Information ==\n" + birthInfo + "\n\n" + theParagraph
        }
        if birthday != "" {
            theParagraph = "== Birthday ==\n" + birthday + "\n\n" + theParagraph
        }
        if deathInfo != "" {
            theParagraph = "== Death Information ==\n" + deathInfo + "\n\n" + theParagraph
        }
        if caseLevel != "" {
            theParagraph = "== Case Level ==\n" + caseLevel + "\n\n" + theParagraph
        }

        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("%%%%%", withString: "\n\n")
        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[http://", withString: "[ http://")
//        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("]", withString: "")
//        theParagraph = theParagraph.stringByReplacingOccurrencesOfString("[", withString: "")
        
        textView.text = theParagraph
        
        profileNameLabel.text = profileName
        
        if imageName != "" {
            var imageURL = NSURL(string: showPic(imageName))
            var imageData = NSData(contentsOfURL: imageURL!)
            profileImage.image = UIImage(data: imageData!)
        } else {
            picutreHeight.setValue(CGFloat(0.0), forKey: "constant")
            pictureTopSpace.setValue(CGFloat(0.0), forKey: "constant")
            profileImage.hidden = true
        }
        
        self.textView.scrollRangeToVisible(NSRange(0...0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func openPageButtonPressed(sender: UIBarButtonItem) {
        var profileURL = profileName.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        profileURL = ("http://scientolipedia.org/info/" + profileURL as NSString) as String
        
        profileURL = profileURL.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        UIApplication.sharedApplication().openURL(NSURL(string:profileURL)!)
        
    }

}