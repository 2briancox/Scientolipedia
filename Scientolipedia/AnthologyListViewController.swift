//
//  AnthologyListViewController.swift
//  Scientolipedia
//
//  Created by Brian on 6/5/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class AnthologyListViewController: UIViewController {
    
    var anthologyNames: [String] = []
    
    @IBOutlet weak var spaceAB: NSLayoutConstraint!
    @IBOutlet weak var spaceBC: NSLayoutConstraint!
    @IBOutlet weak var spaceCD: NSLayoutConstraint!
    @IBOutlet weak var spaceDE: NSLayoutConstraint!
    @IBOutlet weak var spaceEF: NSLayoutConstraint!
    @IBOutlet weak var spaceFG: NSLayoutConstraint!
    @IBOutlet weak var spaceGH: NSLayoutConstraint!
    @IBOutlet weak var spaceHI: NSLayoutConstraint!
    @IBOutlet weak var spaceIJ: NSLayoutConstraint!
    @IBOutlet weak var spaceJK: NSLayoutConstraint!
    @IBOutlet weak var spaceKL: NSLayoutConstraint!
    @IBOutlet weak var spaceLM: NSLayoutConstraint!
    @IBOutlet weak var spaceMN: NSLayoutConstraint!
    @IBOutlet weak var spaceNO: NSLayoutConstraint!
    @IBOutlet weak var spaceOP: NSLayoutConstraint!
    @IBOutlet weak var spacePQ: NSLayoutConstraint!
    @IBOutlet weak var spaceQR: NSLayoutConstraint!
    @IBOutlet weak var spaceRS: NSLayoutConstraint!
    @IBOutlet weak var spaceST: NSLayoutConstraint!
    @IBOutlet weak var spaceTU: NSLayoutConstraint!
    @IBOutlet weak var spaceUV: NSLayoutConstraint!
    @IBOutlet weak var spaceVW: NSLayoutConstraint!
    @IBOutlet weak var spaceWX: NSLayoutConstraint!
    @IBOutlet weak var spaceXY: NSLayoutConstraint!
    @IBOutlet weak var spaceYZ: NSLayoutConstraint!
    
    @IBOutlet weak var anthologyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        let frameHeight = self.view.bounds.size.height
        
        let spacing: CGFloat = (frameHeight - 470)/25 as CGFloat
        
        spaceAB.setValue(spacing, forKey: "constant")
        spaceBC.setValue(spacing, forKey: "constant")
        spaceCD.setValue(spacing, forKey: "constant")
        spaceDE.setValue(spacing, forKey: "constant")
        spaceEF.setValue(spacing, forKey: "constant")
        spaceFG.setValue(spacing, forKey: "constant")
        spaceGH.setValue(spacing, forKey: "constant")
        spaceHI.setValue(spacing, forKey: "constant")
        spaceIJ.setValue(spacing, forKey: "constant")
        spaceJK.setValue(spacing, forKey: "constant")
        spaceKL.setValue(spacing, forKey: "constant")
        spaceLM.setValue(spacing, forKey: "constant")
        spaceMN.setValue(spacing, forKey: "constant")
        spaceNO.setValue(spacing, forKey: "constant")
        spaceOP.setValue(spacing, forKey: "constant")
        spacePQ.setValue(spacing, forKey: "constant")
        spaceQR.setValue(spacing, forKey: "constant")
        spaceRS.setValue(spacing, forKey: "constant")
        spaceST.setValue(spacing, forKey: "constant")
        spaceTU.setValue(spacing, forKey: "constant")
        spaceUV.setValue(spacing, forKey: "constant")
        spaceVW.setValue(spacing, forKey: "constant")
        spaceWX.setValue(spacing, forKey: "constant")
        spaceXY.setValue(spacing, forKey: "constant")
        spaceYZ.setValue(spacing, forKey: "constant")
        
        
        var parsingError: NSError? = nil
        var anthologyListAddress = "http://scientolipedia.org/w/index.php?title=Special%3AAsk&q=[[Category%3A+History+of+Scientology]]+OR+[[Category%3A+Anthology]]&po=&eq=yes&p[format]=json&sort_num=&order_num=ASC&p[limit]=500&p[offset]=&p[link]=all&p[sort]=&p[order][ascending]=1&p[headers]=show&p[mainlabel]=&p[intro]=&p[outro]=&p[searchlabel]=%E2%80%A6+further+results&p[default]=&p[prettyprint]=1&eq=yes"
        let anthologyListURL = NSURL(string: anthologyListAddress)
        let anthologyJSONData = NSData(contentsOfURL: anthologyListURL!)
        var anthologyProfileData = NSJSONSerialization.JSONObjectWithData(anthologyJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        
        let videosListAddress = "http://scientolipedia.org/w/index.php?title=Special%3AAsk&q=[[Category%3A+History+of+Scientology]]+[[Category%3A+Videos]]+OR+[[Category%3A+Anthology]]+[[Category%3A+Videos]]&po=&eq=yes&p[format]=json&sort_num=&order_num=ASC&p[limit]=500&p[offset]=&p[link]=all&p[sort]=&p[order][ascending]=1&p[headers]=show&p[mainlabel]=&p[intro]=&p[outro]=&p[searchlabel]=%E2%80%A6+further+results&p[default]=&p[class]=sortable+wikitable+smwtable&eq=yes"
        let videosListURL = NSURL(string: videosListAddress)
        let videosJSONData = NSData(contentsOfURL: videosListURL!)
        var videosParsedData = NSJSONSerialization.JSONObjectWithData(videosJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        
        
        let videosListDict = videosParsedData["results"] as! Dictionary<String, AnyObject>
        
        let shipsListAddress = "http://scientolipedia.org/w/index.php?title=Special%3AAsk&q=[[Category%3A+Sea+Org+Ships]]+&po=&eq=yes&p[format]=json&sort_num=&order_num=ASC&p[limit]=500&p[offset]=&p[link]=all&p[sort]=&p[order][ascending]=1&p[headers]=show&p[mainlabel]=&p[intro]=&p[outro]=&p[searchlabel]=%E2%80%A6+further+results&p[default]=&p[class]=sortable+wikitable+smwtable&eq=yes"
        let shipsListURL = NSURL(string: shipsListAddress)
        let shipsJSONData = NSData(contentsOfURL: shipsListURL!)
        var shipsParsedData = NSJSONSerialization.JSONObjectWithData(shipsJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        
        let shipsListDict = shipsParsedData["results"] as! Dictionary<String, AnyObject>
        
        let profileListAddress = "http://scientolipedia.org/w/index.php?title=Special%3AAsk&q=[[Category%3A+Personal+Profiles]]+[[Category%3A+History+of+Scientology]]+OR+[[Category%3A+Personal+Profiles]]+[[Category%3A+Anthology]]&po=&eq=yes&p[format]=json&sort_num=&order_num=ASC&p[limit]=500&p[offset]=&p[link]=all&p[sort]=&p[order][ascending]=1&p[headers]=show&p[mainlabel]=&p[intro]=&p[outro]=&p[searchlabel]=%E2%80%A6+further+results&p[default]=&p[class]=sortable+wikitable+smwtable&eq=yes"
        let profileListURL = NSURL(string: profileListAddress)
        let profileJSONData = NSData(contentsOfURL: profileListURL!)
        var profileParsedData = NSJSONSerialization.JSONObjectWithData(profileJSONData!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
        
        let profileListDict = profileParsedData["results"] as! Dictionary<String, AnyObject>
        
        var anthologyListDict = anthologyProfileData["results"] as! Dictionary<String, AnyObject>
        
        var anthologyArray = anthologyListDict.keys.array
        
        for video in videosListDict.keys.array {
            for var i = 0; i < anthologyArray.count; i++ {
                if anthologyArray[i] == video || anthologyArray[i] == "Obituaries" {
                    anthologyArray.removeAtIndex(i)
                }
            }
        }
        
        for ship in shipsListDict.keys.array {
            for var i = 0; i < anthologyArray.count; i++ {
                if anthologyArray[i] == ship {
                    anthologyArray.removeAtIndex(i)
                    i--
                }
            }
        }
        
        for profile in profileListDict.keys.array {
            for var i = 0; i < anthologyArray.count; i++ {
                if anthologyArray[i] == profile {
                    anthologyArray.removeAtIndex(i)
                    i--
                }
            }
        }
        
        for anthology in anthologyArray {
            anthologyNames.append(anthology)
        }
        
        anthologyNames = anthologyNames.sorted{
            (nameOne: String, nameTwo: String) -> Bool in
            return nameOne < nameTwo
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToLetter (letter: String) {
        for var i = 0; i < anthologyNames.count; i++ {
            if (anthologyNames[i] as NSString).substringToIndex(1) == letter {
                anthologyTableView.scrollToRowAtIndexPath(NSIndexPath(forItem: i, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                break
            }
        }
    }
    
    //TableView Functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnthologyListTableViewCell = anthologyTableView.dequeueReusableCellWithIdentifier("anthologyCell") as! AnthologyListTableViewCell
        cell.anthologyNameLabel.text = anthologyNames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.anthologyTableView.deselectRowAtIndexPath(indexPath, animated: false)
        performSegueWithIdentifier("showAnthology", sender: indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anthologyNames.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    @IBAction func aButtonPressed(sender: UIButton) {
        scrollToLetter("1")
    }
    @IBAction func bButtonPressed(sender: UIButton) {
        scrollToLetter("B")
    }
    @IBAction func cButtonPressed(sender: UIButton) {
        scrollToLetter("C")
    }
    @IBAction func dButtonPressed(sender: UIButton) {
        scrollToLetter("D")
    }
    @IBAction func eButtonPressed(sender: UIButton) {
        scrollToLetter("E")
    }
    @IBAction func fButtonPressed(sender: UIButton) {
        scrollToLetter("F")
    }
    @IBAction func gButtonPressed(sender: UIButton) {
        scrollToLetter("G")
    }
    @IBAction func hButtonPressed(sender: UIButton) {
        scrollToLetter("H")
    }
    @IBAction func iButtonPressed(sender: UIButton) {
        scrollToLetter("I")
    }
    @IBAction func jButtonPressed(sender: UIButton) {
        scrollToLetter("J")
    }
    @IBAction func kButtonPressed(sender: UIButton) {
        scrollToLetter("K")
    }
    @IBAction func lButtonPressed(sender: UIButton) {
        scrollToLetter("L")
    }
    @IBAction func mButtonPressed(sender: UIButton) {
        scrollToLetter("M")
    }
    @IBAction func nButtonPressed(sender: UIButton) {
        scrollToLetter("N")
    }
    @IBAction func oButtonPressed(sender: UIButton) {
        scrollToLetter("O")
    }
    @IBAction func pButtonPressed(sender: UIButton) {
        scrollToLetter("P")
    }
    @IBAction func qButtonPressed(sender: UIButton) {
        scrollToLetter("Q")
    }
    @IBAction func rButtonPressed(sender: UIButton) {
        scrollToLetter("R")
    }
    @IBAction func sButtonPressed(sender: UIButton) {
        scrollToLetter("S")
    }
    @IBAction func tButtonPressed(sender: UIButton) {
        scrollToLetter("T")
    }
    @IBAction func uButtonPressed(sender: UIButton) {
        scrollToLetter("U")
    }
    @IBAction func vButtonPressed(sender: UIButton) {
        scrollToLetter("V")
    }
    @IBAction func wButtonPressed(sender: UIButton) {
        scrollToLetter("W")
    }
    @IBAction func xButtonPressed(sender: UIButton) {
        scrollToLetter("X")
    }
    @IBAction func yButtonPressed(sender: UIButton) {
        scrollToLetter("Y")
    }
    @IBAction func zButtonPressed(sender: UIButton) {
        scrollToLetter("Z")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        (segue.destinationViewController as! AnthologyViewController).anthologyName = anthologyNames[sender as! Int]
    }
}
