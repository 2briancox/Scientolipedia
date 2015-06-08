//
//  LegalViewController.swift
//  Scientolipedia
//
//  Created by Brian on 5/18/15.
//  Copyright (c) 2015 Rainien.com, LLC. All rights reserved.
//

import UIKit
import MessageUI

class LegalViewController: UIViewController {

    @IBOutlet weak var legalTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.legalTextView.scrollRangeToVisible(NSRange(0...0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
