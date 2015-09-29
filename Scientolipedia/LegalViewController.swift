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
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }

}
