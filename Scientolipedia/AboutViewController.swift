//
//  AboutViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/16/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func briansEmailPressed(sender: UIButton) {
        var address = NSURL(string: "message:2briancox@gmail.com")
        UIApplication.sharedApplication().openURL(address!)
    }
    
    
    @IBAction func legalInfoPressed(sender: UIButton) {
        performSegueWithIdentifier("showLegal", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
