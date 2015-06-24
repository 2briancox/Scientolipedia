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
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var hButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    @IBOutlet weak var jButton: UIButton!
    @IBOutlet weak var kButton: UIButton!
    @IBOutlet weak var lButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var nButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var qButton: UIButton!
    @IBOutlet weak var rButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var tButton: UIButton!
    @IBOutlet weak var uButton: UIButton!
    @IBOutlet weak var vButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var yButton: UIButton!
    @IBOutlet weak var zButton: UIButton!
    
    @IBOutlet weak var anthologyTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()

        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        let frameHeight = self.view.bounds.size.height
        
        let spacing: CGFloat = (frameHeight - 470)/25 as CGFloat
        
        self.anthologyTableView.userInteractionEnabled = false
        
        self.anthologyTableView.hidden = true
        self.aButton.hidden = true
        self.bButton.hidden = true
        self.cButton.hidden = true
        self.dButton.hidden = true
        self.eButton.hidden = true
        self.fButton.hidden = true
        self.gButton.hidden = true
        self.hButton.hidden = true
        self.iButton.hidden = true
        self.jButton.hidden = true
        self.kButton.hidden = true
        self.lButton.hidden = true
        self.mButton.hidden = true
        self.nButton.hidden = true
        self.oButton.hidden = true
        self.pButton.hidden = true
        self.qButton.hidden = true
        self.rButton.hidden = true
        self.sButton.hidden = true
        self.tButton.hidden = true
        self.uButton.hidden = true
        self.vButton.hidden = true
        self.wButton.hidden = true
        self.xButton.hidden = true
        self.yButton.hidden = true
        self.zButton.hidden = true
        
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
        
        var urlError = false
        var parsingError: NSError? = nil
        var anthologyParsedData: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
        
        let anthologyListAddress = "http://scientolipedia.org/w/index.php?title=Special%3AAsk&q=[[Category%3AHistory+of+Scientology]]+OR+[[Category%3AAnthology]]&po=%3FCategory%0D%0A&eq=yes&p[format]=json&sort_num=&order_num=ASC&p[limit]=500&p[offset]=&p[link]=all&p[sort]=&p[order][ascending]=1&p[headers]=show&p[mainlabel]=&p[intro]=&p[outro]=&p[searchlabel]=further+results&p[default]=&p[class]=sortable+wikitable+smwtable&eq=yes"
        
        let task2 = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: anthologyListAddress)!, completionHandler: { (data, response, error) -> Void in
            
            
            if error == nil {
                
                anthologyParsedData = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
                
            } else {
                
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText(header: "Warning", message: "This list was not able to load from the server.  Please try again.")
                    
                } else {
                    
                    var data1 = NSData(contentsOfURL: NSURL(string: anthologyListAddress)!)
                    
                    anthologyParsedData = NSJSONSerialization.JSONObjectWithData(data1!, options: .AllowFragments, error: &parsingError) as! [String: AnyObject]
                    
                    var anthologyKeys = (anthologyParsedData["results"] as! Dictionary<String, AnyObject>).keys.array
                    
                    for var i = 0; i < anthologyKeys.count; i++ {
                        
                        let article = (anthologyParsedData["results"] as! Dictionary<String, AnyObject>)[anthologyKeys[i]] as! Dictionary<String, AnyObject>
                        
                        let printouts = article["printouts"] as! Dictionary<String, AnyObject>
                        
                        let articleInfoArray = printouts["Category"] as! [[String: AnyObject]]
                        
                        var badArticle = false
                        
                        for articleInfo in articleInfoArray {
                            if (articleInfo["fulltext"] as! String) == "Category:Sea Org Ships" || (articleInfo["fulltext"] as! String) == "Category:Videos" || (articleInfo["fulltext"] as! String) == "Personal Profiles"  {
                                badArticle = true
                            }
                        }
                        
                        if badArticle {
                            anthologyKeys.removeAtIndex(i)
                            i--
                        }
                        
                    }
                    
                    anthologyKeys = anthologyKeys.sorted{
                        (nameOne: String, nameTwo: String) -> Bool in
                        return nameOne < nameTwo
                    }
                    
                    self.anthologyNames = anthologyKeys
                    
                    self.anthologyTableView.hidden = false
                    self.aButton.hidden = false
                    self.bButton.hidden = false
                    self.cButton.hidden = false
                    self.dButton.hidden = false
                    self.eButton.hidden = false
                    self.fButton.hidden = false
                    self.gButton.hidden = false
                    self.hButton.hidden = false
                    self.iButton.hidden = false
                    self.jButton.hidden = false
                    self.kButton.hidden = false
                    self.lButton.hidden = false
                    self.mButton.hidden = false
                    self.nButton.hidden = false
                    self.oButton.hidden = false
                    self.pButton.hidden = false
                    self.qButton.hidden = false
                    self.rButton.hidden = false
                    self.sButton.hidden = false
                    self.tButton.hidden = false
                    self.uButton.hidden = false
                    self.vButton.hidden = false
                    self.wButton.hidden = false
                    self.xButton.hidden = false
                    self.yButton.hidden = false
                    self.zButton.hidden = false
                    
                    self.anthologyTableView.userInteractionEnabled = true
                    
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.stopAnimating()
                    
                    self.anthologyTableView.reloadData()
                    self.anthologyTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                    
                }
                    
            }
            
        })
        
        
        
        task2.resume()
        

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
        if anthologyNames[indexPath.row] != "" {
            performSegueWithIdentifier("showAnthology", sender: indexPath.row)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anthologyNames.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    @IBAction func aButtonPressed(sender: UIButton) {
        scrollToLetter("A")
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
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
}
