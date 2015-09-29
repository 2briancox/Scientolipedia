//
//  AboutViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/16/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func briansEmailPressed(sender: UIButton) {
        let messageBody: NSString = "== This message was sent through the Scientolipedia phone app. ==\n\n"
        let toRecipients: [String] = ["2briancox@gmail.com"]
        let mailComposer: MFMailComposeViewController = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(toRecipients )
        mailComposer.setSubject("Scientolipedia App")
        mailComposer.setMessageBody(messageBody as String, isHTML: false)
        self.presentViewController(mailComposer, animated: true, completion: nil)
    }
    
    
    @IBAction func legalInfoPressed(sender: UIButton) {
        performSegueWithIdentifier("showLegal", sender: self)
    }

    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
