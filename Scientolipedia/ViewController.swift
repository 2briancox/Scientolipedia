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
        let menuItem2: Dictionary<String, String> = ["name": "Glossary", "explanation": "Define Scientology Nomenclature"]
        let menuItem3: Dictionary<String, String> = ["name": "Biographies", "explanation": "Stories of Scientologists"]
        let menuItem4: Dictionary<String, String> = ["name": "LRH Biography", "explanation": "Stories of L. Ron Hubbard"]
        let menuItem5: Dictionary<String, String> = ["name": "History of Scientology", "explanation": "Know Our Past"]
        let menuItem6: Dictionary<String, String> = ["name": "Main Page", "explanation": "Browse Scientolipedia.org"]
        
        mainMenuArray = [menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6]
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
        return 6
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
            println("ZERO")
            performSegueWithIdentifier("showAuditorListSegue", sender: self)
        default:
            println(indexPath.row)
        }
    }

}

