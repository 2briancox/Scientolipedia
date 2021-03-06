//
//  AuditorListViewController.swift
//  Scientolipedia
//
//  Created by Brian on 4/26/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class AuditorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var auditorTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var auditorsSorted: [AuditorModel] = []
    var countryList: [String] = []
    var auditorCountrySortHold: [AuditorModel] = []
    var auditors:[AuditorModel] = []
    var auditorPerCountry: [[AuditorModel]] = [[]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://scientolipedia.org/w/index.php?title=Special:Ask&q=[[Category%3AAuditors]]&p=format%3Djson%2Flink%3Dall%2Fheaders%3Dshow%2Fmainlabel%3DAuditors%2Fsearchlabel%3D%E2%80%A6-20further-20results%2Fclass%3Dsortable-20wikitable-20smwtable&po=%3FCountry%0A%3FTraining+Level%0A%3FState%0A&sort=Country&order=ascending&limit=500&eq=no")!, completionHandler: { (data, response, error) -> Void in
            
            var urlError = false
            var keysForDict: [String] = []
            var auditorArray: [String: AnyObject] = Dictionary<String, AnyObject>()
            
            if error == nil {
                
                /* Parse the data into usable form */
                var parsedAuditorJSON = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! [String: AnyObject]
                
                auditorArray = parsedAuditorJSON["results"] as! [String: AnyObject]
                
                keysForDict = Array(auditorArray.keys) as [String]
                
            } else {

                urlError = true
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if urlError == true {
                    
                    self.showAlertWithText("Warning", message: "This page cannot load right now. Please try again later.")

                } else {
                    
                    for var i = 0; i < keysForDict.count; i++ {
                        let params = auditorArray[keysForDict[i]] as! [String: AnyObject]
                        
                        let prints = params["printouts"] as! [String: AnyObject]
                        
                        let name: String = params["fulltext"] as! String
                        
                        let auditorState = (prints["State"] as! [String]).count > 0 ? (prints["State"] as! [String])[0] : ""
                        
                        let auditorCountry = (prints["Country"] as! [String]).count > 0 ? (prints["Country"] as! [String])[0] : ""
                        
                        let auditorTraining = (prints["Training Level"] as! [String]).count > 0 ? "Level: " + (prints["Training Level"] as! [String])[0] : ""
                        
                        let auditor: AuditorModel = AuditorModel(name: name, level: auditorTraining, country: auditorCountry, state: auditorState)
                        self.auditors.append(auditor)
                    }
                    
                    for auditor in self.auditors {
                        var inThere = false
                        for country in self.countryList {
                            if auditor.country == country {
                                inThere = true
                            }
                        }
                        if !inThere {
                            self.countryList.append(auditor.country)
                        }
                    }
                    
                    self.countryList = self.countryList.sort{
                        (countryOne: String, countryTwo: String) -> Bool in
                        
                        return countryOne < countryTwo
                    }
                    
                    for country in self.countryList {
                        self.auditorCountrySortHold.removeAll(keepCapacity: true)
                        for auditor in self.auditors {
                            if auditor.country == country {
                                self.auditorCountrySortHold.append(auditor)
                            }
                        }
                        
                        self.auditorCountrySortHold = self.auditorCountrySortHold.sort{
                            (auditorOne: AuditorModel, auditorTwo: AuditorModel) -> Bool in
                            
                            return auditorOne.name < auditorTwo.name
                        }
                        
                        for auditor in self.auditorCountrySortHold {
                            self.auditorsSorted.append(auditor)
                        }
                        
                        self.auditorPerCountry.append(self.auditorsSorted)
                        self.auditorsSorted.removeAll(keepCapacity: true)
                        
                    }
                    
                    self.auditorTableView.backgroundColor = UIColor(red: 0xff, green: 0xF0, blue: 85)
                    self.auditorPerCountry.removeAtIndex(0)
                    self.auditorTableView.reloadData()
                    self.activityIndicator.hidesWhenStopped = true
                    self.activityIndicator.stopAnimating()

                }
            }
        })
        
        task.resume()
        self.auditorTableView.reloadData()
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return countryList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auditorPerCountry[section].count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countryList[section]
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: AuditorListViewCell = auditorTableView.dequeueReusableCellWithIdentifier("auditorListViewCell") as! AuditorListViewCell

        let thisAuditor = auditorPerCountry[indexPath.section][indexPath.row]
        
        cell.auditorLabel.text = thisAuditor.name
        cell.classLabel.text = thisAuditor.level
        cell.countryLabel.text = thisAuditor.country
        cell.stateLabel.text = thisAuditor.state
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showAuditorPage", sender: self)
        self.auditorTableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func showError() {
        
        let myAlert = UIAlertController(title: "There is a connection error with Scientolipedia.org.", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let targetVC = segue.destinationViewController as! AuditorPageViewController
        let indexPath = self.auditorTableView.indexPathForSelectedRow
        targetVC.theAuditor = auditorPerCountry[indexPath!.section][indexPath!.row]
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        let alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}
