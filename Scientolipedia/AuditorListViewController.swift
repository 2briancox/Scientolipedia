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
    
    var auditors:[AuditorModel] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        var urlString = "http://scientolipedia.org/w/index.php?title=Special:Ask&q=[[Category%3AAuditors]]&p=format%3Dbroadtable%2Flink%3Dall%2Fheaders%3Dshow%2Fmainlabel%3DAuditors%2Fsearchlabel%3D%E2%80%A6-20further-20results%2Fclass%3Dsortable-20wikitable-20smwtable&po=%3FCountry%0A%3FTraining+Level%0A%3FState%0A&sort=Country&order=ascending&limit=500&eq=no"
//        
//        var urlSource = NSURL(string: urlString)
//
//            let task = NSURLSession.sharedSession().dataTaskWithURL(urlSource!, completionHandler: { (data, response, error) -> Void in
//                var urlError = false
//                
//                if error == nil {
//                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
//                    
//                    var urlContentArray = urlContent.componentsSeparatedByString("<td class=\"Auditors smwtype_wpg\">")
//                    
//                        if urlContentArray.count > 0 {
//                        for var i = 1; i < urlContentArray.count; i++ {
//                            
//                            let nameResult = (urlContentArray[i] as! NSString).componentsSeparatedByString("title=\"")
//                            var auditorName: String = (nameResult[1] as! NSString).componentsSeparatedByString("\"")[0] as! String
//                            
//                            let classResult = (urlContentArray[i] as! NSString).componentsSeparatedByString("class=\"Training-Level smwtype_txt\">")
//                            var auditorClass = ""
//                            
//                            if classResult.count > 1 {
//                                auditorClass = (classResult[1] as! NSString).componentsSeparatedByString("</td>")[0] as! String
//                            }
//                                
//                            let countryResult = (urlContentArray[i] as! NSString).componentsSeparatedByString("class=\"Country smwtype_txt\">")
//                            var auditorCountry = ""
//                            
//                            if countryResult.count > 1 {
//                                auditorCountry = (countryResult[1] as! NSString).componentsSeparatedByString("</td>")[0] as! String
//                            }
//                            
//                            let stateResult = (urlContentArray[i] as! NSString).componentsSeparatedByString("<td class=\"State smwtype_txt\">")
//                            var auditorState = ""
//                            
//                            if stateResult.count > 1 {
//                                auditorState = (stateResult[1] as! NSString).componentsSeparatedByString("</td>")[0] as! String
//                            }
//                            
//                            let urlResult = (urlContentArray[i] as! NSString).componentsSeparatedByString("<a href=\"")
//                            
//                            let auditorURL = NSURL(string: "http://scientolipedia.org" + ((urlResult[1] as! NSString).componentsSeparatedByString("\"")[0] as! String))
//                            
//                            var auditorX: AuditorModel = AuditorModel(name: auditorName, level: auditorClass, country: auditorCountry, state: auditorState, address: auditorURL!)
//
//                            
//                            self.auditors.append(auditorX)
//                            
//                            
//                        }
//                        
//                    } else {
//                        
//                        urlError = true
//                        
//                    }
//                    
//                } else {
//                    
//                    urlError = true
//                    
//                }
//                
//            })
//            task.resume()
//        
//            self.auditorTableView.reloadData()
        
        /* Path for JSON file */
        var pathForAuditorJSON = NSURL(string: "http://scientolipedia.org/w/index.php?title=Special:Ask&q=[[Category%3AAuditors]]&p=format%3Djson%2Flink%3Dall%2Fheaders%3Dshow%2Fmainlabel%3DAuditors%2Fsearchlabel%3D%E2%80%A6-20further-20results%2Fclass%3Dsortable-20wikitable-20smwtable&po=%3FCountry%0A%3FTraining+Level%0A%3FState%0A&sort=Country&order=ascending&limit=500&eq=no")
        
        /* Raw JSON data */
        var rawAuditorJSON = NSData(contentsOfURL: pathForAuditorJSON!)
        
        /* Error object */
        var parsingAuditorError: NSError? = nil
        
        /* Parse the data into usable form */
        var parsedAuditorJSON = NSJSONSerialization.JSONObjectWithData(rawAuditorJSON!, options: .AllowFragments, error: &parsingAuditorError) as! [String: AnyObject]
        
        var auditorArray = parsedAuditorJSON["results"] as! [String: AnyObject]
        
        var keysForDict = auditorArray.keys.array as [String]
        
        for var i = 0; i < keysForDict.count; i++ {
            let params = auditorArray[keysForDict[i]] as! [String: AnyObject]
            
            let prints = params["printouts"] as! [String: AnyObject]
            let fullUrl = params["fullurl"] as! String
            
            let actualURL = NSURL(string: fullUrl) as NSURL!
            
            let name: String = params["fulltext"] as! String
            
            let auditorState = (prints["State"] as! [String]).count > 0 ? (prints["State"] as! [String])[0] : ""
            
            let auditorCountry = (prints["Country"] as! [String]).count > 0 ? (prints["Country"] as! [String])[0] : ""
            
            let auditorTraining = (prints["Training Level"] as! [String]).count > 0 ? "Level: " + (prints["Training Level"] as! [String])[0] : ""
            
            let auditor: AuditorModel = AuditorModel(name: name, level: auditorTraining, country: auditorCountry, state: auditorState, address: actualURL)
            auditors.append(auditor)
        }
        
        auditors = auditors.sorted{
            (auditorOne: AuditorModel, auditorTwo: AuditorModel) -> Bool in
            
            return auditorOne.country < auditorTwo.country
        }
        
        self.auditorTableView.reloadData()
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auditors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: AuditorListViewCell = auditorTableView.dequeueReusableCellWithIdentifier("auditorListViewCell") as! AuditorListViewCell
        
        if auditors.count > 0 {
            
            let thisAuditor = auditors[indexPath.row]
            
            cell.auditorLabel.text = thisAuditor.name
            cell.classLabel.text = thisAuditor.level
            cell.countryLabel.text = thisAuditor.country
            cell.stateLabel.text = thisAuditor.state
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func showError() {
        
        let myAlert = UIAlertController(title: "There is a connection error with Scientolipedia.org.", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sortAuditors (auditorOne: AuditorModel, auditorTwo: AuditorModel) -> Bool {
        return auditorOne.country < auditorTwo.country
    }
}
