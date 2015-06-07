//
//  ViewController.swift
//  Scientolipedia
//
//  Created by Brian on 4/23/15.
//  Copyright (c) 2015 Scientolipedia.com.  All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var mainMenuArray: [Dictionary<String,String>] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuItem1: Dictionary<String, String> = ["name": "Auditors", "explanation": "Browse Independent Auditors"]
        let menuItem3: Dictionary<String, String> = ["name": "Glossary", "explanation": "Define Scientology Nomenclature"]
        let menuItem2: Dictionary<String, String> = ["name": "Biographies", "explanation": "Stories of Scientologists"]
//        let menuItem4: Dictionary<String, String> = ["name": "LRH Biography", "explanation": "Stories of L. Ron Hubbard"]
        let menuItem5: Dictionary<String, String> = ["name": "Anthology", "explanation": "Know Our Past"]
        let menuItem6: Dictionary<String, String> = ["name": "Main Page", "explanation": "Browse Scientolipedia.org"]
        let menuItem8: Dictionary<String, String> = ["name": "About", "explanation": "Background on App"]
        let menuItem7: Dictionary<String, String> = ["name": "Participate", "explanation": "Chip in and help!"]
        
        mainMenuArray = [menuItem1, menuItem2, menuItem3, menuItem5, menuItem6, menuItem7, menuItem8]
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
        return self.mainMenuArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: TableViewCell = tableView.dequeueReusableCellWithIdentifier("mainViewCell") as! TableViewCell
        
        let menuItem:Dictionary = mainMenuArray[indexPath.row]
        
        cell.nameSectionLabel.text = menuItem["name"]
        cell.explanationSectionLabel.text = menuItem["explanation"]
        cell.imageViewSection.image = UIImage(named: menuItem["name"]!)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("showAuditorListSegue", sender: self)
        case 1:
            performSegueWithIdentifier("showBiographies", sender: self)
        case 2:
            performSegueWithIdentifier("showGlossary", sender: self)
        case 3:
            performSegueWithIdentifier("showAnthologyList", sender: self)
        case 4:
            let address = NSURL(string: "http://scientolipedia.org/info/Main_Page")
            UIApplication.sharedApplication().openURL(address!)
        case 5:
            var address = NSURL(string: "http://scientolipedia.org/info/Project_Supporters")
            UIApplication.sharedApplication().openURL(address!)
        case 6:
            performSegueWithIdentifier("showAbout", sender: self)
        default:
            println(indexPath.row)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}

