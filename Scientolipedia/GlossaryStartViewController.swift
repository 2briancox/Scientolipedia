//
//  GlossaryStartViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/18/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class GlossaryStartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var definitionTextView: UITextView!
    
    @IBOutlet weak var wordTableView: UITableView!
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    
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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var lettersArray: [String] = []
    
    var wordList: [String] = []
    
    var wordURLStrings: [String] = []
    
    var wordNSURL: NSURL? = nil
    
    
    //TableView functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: WordTableViewCell = wordTableView.dequeueReusableCellWithIdentifier("wordCell") as! WordTableViewCell
        
        cell.wordNameInCell.text = wordList[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.wordTitleLabel.text = "Definition: ..."
        definitionTextView.text = "\n\n\n                           ... Loading ... "
        
        self.activityIndicator.startAnimating()
        
        self.wordTitleLabel.textColor = UIColor.lightGrayColor()
        self.definitionTextView.textColor = UIColor.lightGrayColor()
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: wordURLStrings[indexPath.row])!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            
            var definition = ""
            
            if error == nil {
                
                println("error == nil")
                
                self.wordNSURL = NSURL(string: self.wordURLStrings[indexPath.row])
                
                var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                
                var urlContentArray: [String] = []
                
                var hasTable = false
                
                var takenFromLink = false
                
                if urlContent.containsString("</td></tr></table>\n<p>") {
                    urlContentArray = urlContent.componentsSeparatedByString("</td></tr></table>\n<p>") as! [String]
                    hasTable = true

                } else if urlContent.containsString("</td></tr><tr><th> Definition\n</th>\n<td>") {
                    urlContentArray = urlContent.componentsSeparatedByString("</td></tr><tr><th> Definition\n</th>\n<td>") as! [String]

                }
                
                println("urlContentArray")
                
                if urlContentArray.count > 0 {
                    
                    println("urlContentArray.count > 0")
                    
                    var definitionArray: [String] = []
                    
                    if hasTable {
                        
                        definitionArray = urlContentArray[1].componentsSeparatedByString("</p>")
                        
                        definition = definitionArray[0] as String
                        
                        println("hasTable")
                        
                    } else {
                        
                        definitionArray = urlContentArray[1].componentsSeparatedByString("\n</td></tr>")
                        
                        definition = definitionArray[0] as String
                    }
                    
                    definition = definition.stringByReplacingOccurrencesOfString("<b>", withString: "")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("<p>", withString: "")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("</b>", withString: "")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("</i>", withString: "")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("<i>", withString: "")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("&#8220;", withString: "\"")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("&#8221;", withString: "\"")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("&#160;", withString: " ")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("&#8217;", withString: "'")
                    
                    definition = definition.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
                    
                
                    if (definition as NSString).containsString("<span class=\"mw-lingo-tooltip \"><span class=\"mw-lingo-tooltip-abbr\">") {
                        var defTemp: String = ""
                        let definitionSplitArray = definition.componentsSeparatedByString("<span class=\"mw-lingo-tooltip \"><span class=\"mw-lingo-tooltip-abbr\">") as [String]
                        defTemp = definitionSplitArray[0]

                        for var i = 1; i < definitionSplitArray.count; i++ {
                            var tempStringSandwichedPart: String = (definitionSplitArray[i] as NSString).componentsSeparatedByString("</span><span class=\"mw-lingo-tooltip-tip \"><span class=\"mw-lingo-tooltip-definition \">")[0] as! String
                            let tempStringLastPart = definitionSplitArray[i].componentsSeparatedByString("</span></span></span>")[1]
                            defTemp += tempStringSandwichedPart + tempStringLastPart
                        }
                        definition = defTemp
                    }
                    
                    while (definition as NSString).containsString("<a href=") {
                        let defSplitArray = definition.componentsSeparatedByString("<a href=")
                        definition = defSplitArray[0] + defSplitArray[1].componentsSeparatedByString(">")[1]
                        definition = definition + ">"
                        if defSplitArray.count > 2 {
                            for var i = 2; i < defSplitArray.count; i++ {
                                definition = definition + ">" + defSplitArray[i]
                            }
                        }
                    }
                    
                    definition = definition.stringByReplacingOccurrencesOfString("</a>", withString: "")
                    definition = definition.stringByReplacingOccurrencesOfString(">", withString: "")
                    
                } else {
                    
                    self.wordNSURL = nil
                    urlError = true
                    
                }
                
            } else {
                
                self.wordNSURL = nil
                urlError = true
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText(header: "Warning", message: "That word was not able to load from the server.")
                    
                } else {
                    
                    if (definition as NSString).containsString("</span><span class=\"mw-lingo-tooltip-tip \"><span class=\"mw-lingo-tooltip-definition \">") {
                        definition = definition.componentsSeparatedByString("</span><span class=\"mw-lingo-tooltip-tip \"><span class=\"mw-lingo-tooltip-definition \">")[1]
                    }
                    
                    self.definitionTextView.text = definition
                    self.wordTitleLabel.textColor = UIColor(white: CGFloat(0.0), alpha: CGFloat(1.0))
                    self.definitionTextView.textColor = UIColor(white: CGFloat(0.0), alpha: CGFloat(1.0))
                    self.definitionTextView.scrollRangeToVisible(NSRange(0...0))
                    
                    self.activityIndicator.stopAnimating()
                    
                }
            }
            
        })
        
        task.resume()
        
        self.wordTitleLabel.text = "Definition: " + wordList[indexPath.row]

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        
        wordNSURL = nil
        
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
        
        var parsingAuditorError: NSError? = nil
        
        let glossaryURL = NSURL(string: "http://scientolipedia.org/w/index.php?title=Special:Ask&offset=0&limit=500&q=[[Category%3A+Glossary]]%0A&p=format%3Djson%2Flink%3Dall%2Fheaders%3Dshow%2Fsearchlabel%3D%E2%80%A6-20further-20results%2Fclass%3Dsortable-20wikitable-20smwtable&eq=yes")
        var parsedGlossaryJSON: [String: AnyObject] = Dictionary<String, AnyObject>()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(glossaryURL!, completionHandler: { (data, response, error) -> Void in
            
                var urlError = false
                
                if error == nil {
            
                    parsedGlossaryJSON = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
                    
                } else {
                    
                    self.wordNSURL = nil
                    urlError = true
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        self.showAlertWithText(header: "Warning", message: "The word list was not found on the server.")
                        
                    } else {
                        
                        let wordListDict = parsedGlossaryJSON["results"] as! Dictionary<String, AnyObject>
                        
                        let words = wordListDict.keys.array
                        
                        self.wordList.removeAll(keepCapacity: false)
                        self.wordURLStrings.removeAll(keepCapacity: false)
                        self.lettersArray.removeAll(keepCapacity: false)
                        
                        for word in words {
                            self.wordList.append(word)
                        }
                        
                        self.wordList = self.wordList.sorted{
                            (wordOne: String, wordTwo: String) -> Bool in
                            return wordOne < wordTwo
                        }
                        
                        for word in self.wordList {
                            let letter = (word as NSString).substringToIndex(1)
                            self.lettersArray.append(letter)
                            let wordURL: String = (wordListDict[word] as! Dictionary<String, AnyObject>)["fullurl"] as! String!
                            self.wordURLStrings.append(wordURL)
                        }
                        
                        for var i = self.lettersArray.count - 1; i > 0; i-- {
                            if self.lettersArray[i] == self.lettersArray[i-1] {
                                self.lettersArray.removeAtIndex(i)
                            }
                        }
                        
                        self.wordTableView.reloadData()
                        
                        self.activityIndicator.hidesWhenStopped = true
                        self.activityIndicator.stopAnimating()
                        
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
    
    func scrollToLetter (letter: String) {
        for var i = 0; i < wordList.count; i++ {
            if (wordList[i] as NSString).substringToIndex(1) == letter {
                wordTableView.scrollToRowAtIndexPath(NSIndexPath(forItem: i, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                break
            }
        }
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
    
    
    @IBAction func sendWordPressed(sender: AnyObject) {
        
        
        if (wordNSURL != nil) {
            let wordDefInfo = [wordTitleLabel.text! + " -\n\n" + definitionTextView.text + "\n\nSent from the Scientolipedia iOS App.\n", wordNSURL!]
            let nextController = UIActivityViewController(activityItems: wordDefInfo, applicationActivities: nil)

            self.presentViewController(nextController, animated: true, completion: nil)
        } else {
            showAlertWithText(header: "No word selected", message: "Please choose a word to send first.")
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
