//
//  ViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/5/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit
import MessageUI
import MobileCoreServices

var cameFromEmailComposer:Bool = false

var gCompanyName = ""
var gAddress = ""
var gState = ""
var gZip = ""
var gCountry = ""
var gPhone = ""
var gWeArePicker = ""
var gWeArePickerIndex = 0

var gFirstName = ""
var gLastName = ""
var gJobTitle = ""
var gEmail = ""

var gLotSizes = ""
var gAnnualVolume = ""
var gMaterialType = ""
var gPriorOperation = ""
var gReason = ""
var gInterestedInPicker = ""
var gInterestedInPickerIndex = 0

var gCompanyValid = false
var gPersonalValid = false
var gPartsValid = false

var gFilename = ""
var gFullPath = ""

let QuoteDefaults = NSUserDefaults.standardUserDefaults()
let defaultValues = ["dCompanyName" : "",  "dAddress" : "",  "dState" : "",  "dZip" : "",  "dCountry" : "United States",  "dPhone" : "","dFirstName" : "",  "dLastName" : "",  "dJobTitle" : "",  "dEmail" : ""]

class ViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var CompanyCheck: UIImageView!
    @IBOutlet weak var PersonalCheck: UIImageView!
    @IBOutlet weak var PartsCheck: UIImageView!
    @IBOutlet weak var PhotoCheck: UIImageView!
    @IBOutlet weak var FileUploadCheck: UIImageView!
    
 
    @IBAction func TakePhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        
        cameFromEmailComposer = false
    }
    
    @IBAction func SelectPhoto(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        MyImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        cameFromEmailComposer = false
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var MyImageView: UIImageView!
    
    @IBAction func composeEmail(sender: AnyObject) {
        if gCompanyValid && gPersonalValid && gPartsValid && MyImageView.image != nil {
            if MFMailComposeViewController.canSendMail() {
            
                let picker = MFMailComposeViewController()
            
                picker.mailComposeDelegate = self
                picker.setToRecipients(["jscoltock3@gmail.com","tomg@ableelectropolishing.com","scottp@ableelectropolishing.com"])
                picker.setSubject("Request for Quote")
                
                //var Body = "<b>Request for Quote from Able Electropolishing</b>\n"
                
                var Body = "REQUEST FOR QUOTE"
                Body = Body + "\n\nCompany Name: " + gCompanyName
                Body = Body + "\nAddress: " + gAddress
                Body = Body + "\nState: " + gState
                Body = Body + "\nZip/Postal Code: " + gZip
                Body = Body + "\nCountry: " + gCountry
                Body = Body + "\nWe are: " + gWeArePicker

                Body = Body + "\n\nRequested By: " + gFirstName + " " + gLastName
                Body = Body + "\nTitle: " + gJobTitle
                Body = Body + "\nWork Phone: " + gPhone
                Body = Body + "\nEmail: " + gEmail
            
                Body = Body + "\n\nLot Sizes: " + gLotSizes
                Body = Body + "\nAnnual Volume: " + gAnnualVolume
                Body = Body + "\nMaterial Type: " + gMaterialType
                Body = Body + "\nPrior Operation: " + gPriorOperation
                Body = Body + "\nInterested In: " + gInterestedInPicker
                Body = Body + "\nPrimary Reason for Service: " + gReason
                
                picker.setMessageBody(Body, isHTML: false)
                
                //let testimage = MyImageView.image
                //let orientedImage = UIImage(CGImage: testimage!.CGImage!, scale: 1, orientation: testimage!.imageOrientation)
                //let imageData: NSData = UIImagePNGRepresentation(orientedImage)!

                let imageData: NSData = UIImagePNGRepresentation(MyImageView.image!)!
                
                picker.addAttachmentData(imageData, mimeType: "image/jpg", fileName: "QuotePart.jpg")
                
                if let fileData = NSData(contentsOfFile: gFullPath) {
                    print("File data loaded.")
                    picker.addAttachmentData(fileData, mimeType: "PDF/pdf", fileName: gFilename)
                }
                
                /*
                if let filePath = NSBundle.mainBundle().pathForResource("swifts", ofType: "wav") {
                    print("File path loaded.")
                    
                    if let fileData = NSData(contentsOfFile: filePath) {
                        print("File data loaded.")
                        picker.addAttachmentData(fileData, mimeType: "audio/wav", fileName: "swifts")
                    }
                }
                */
                presentViewController(picker, animated: true, completion: nil)
                cameFromEmailComposer = true
            }
        }
        else {
            let alertController = UIAlertController(title: "Missing Required Fields", message: "One or more required fields are missing", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuoteDefaults.registerDefaults(defaultValues)
        
        hideKeyboardWhenTappedAround()
        
        gCompanyName = QuoteDefaults.stringForKey("dCompanyName")!
        gAddress = QuoteDefaults.stringForKey("dAddress")!
        gState = QuoteDefaults.stringForKey("dState")!
        gZip = QuoteDefaults.stringForKey("dZip")!
        gCountry = QuoteDefaults.stringForKey("dCountry")!
        gPhone = QuoteDefaults.stringForKey("dPhone")!
        
        gFirstName = QuoteDefaults.stringForKey("dFirstName")!
        gLastName = QuoteDefaults.stringForKey("dLastName")!
        gJobTitle = QuoteDefaults.stringForKey("dJobTitle")!
        gEmail = QuoteDefaults.stringForKey("dEmail")!
    
        ShowValidCheckMarks()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if cameFromEmailComposer {
            MyImageView.image = nil
        }
                ShowValidCheckMarks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ShowValidCheckMarks() {
        if gPersonalValid == true {
            PersonalCheck.image = UIImage(named: "CheckMark")
        }
        else
        {
            PersonalCheck.image = nil
        }
        
        if gCompanyValid == true {
            CompanyCheck.image = UIImage(named: "CheckMark")
        }
        else
        {
            CompanyCheck.image = nil
        }
        
        if gPartsValid == true {
            PartsCheck.image = UIImage(named: "CheckMark")
        }
        else
        {
            PartsCheck.image = nil
        }
        
        if MyImageView .image == nil {
            PhotoCheck.image = nil
        }
        else
        {
            PhotoCheck.image = UIImage(named: "CheckMark")
        }
        
        if gFullPath == "" {
            FileUploadCheck.image = nil
        }
        else
        {
            FileUploadCheck.image = UIImage(named: "CheckMark")
        }
    }
}


extension ViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

