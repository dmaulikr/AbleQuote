//
//  ViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/5/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    
    @IBAction func composeEmail(sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
        
            let picker = MFMailComposeViewController()
        
            picker.mailComposeDelegate = self
            picker.setToRecipients(["jscoltock3@gmail.com"])
            picker.setMessageBody("<b>Request for Quote from Able Electropolishing</b>", isHTML: true)
            picker.setSubject("Request for Quote")
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

