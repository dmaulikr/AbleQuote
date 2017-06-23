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

let QuoteDefaults = UserDefaults.standard
let defaultValues = ["dCompanyName" : "",  "dAddress" : "",  "dState" : "",  "dZip" : "",  "dCountry" : "United States",  "dPhone" : "","dFirstName" : "",  "dLastName" : "",  "dJobTitle" : "",  "dEmail" : "", "dWeArePickerIndex" : 0] as [String : Any]

class ViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var CompanyCheck: UIImageView!
    @IBOutlet weak var PersonalCheck: UIImageView!
    @IBOutlet weak var PartsCheck: UIImageView!
    @IBOutlet weak var PhotoCheck: UIImageView!
    @IBOutlet weak var FileUploadCheck: UIImageView!
    
 
    @IBAction func TakePhoto(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
        cameFromEmailComposer = false
    }
    
    @IBAction func SelectPhoto(_ sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        MyImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        cameFromEmailComposer = false
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var MyImageView: UIImageView!
    
    @IBAction func composeEmail(_ sender: AnyObject) {
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

                let imageData: Data = UIImagePNGRepresentation(MyImageView.image!)!
                
                picker.addAttachmentData(imageData, mimeType: "image/jpg", fileName: "QuotePart.jpg")
                
                if let fileData = try? Data(contentsOf: URL(fileURLWithPath: gFullPath)) {
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
                present(picker, animated: true, completion: nil)
                cameFromEmailComposer = true
            }
        }
        else {
            let alertController = UIAlertController(title: "Missing Required Fields", message: "One or more required fields are missing", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        QuoteDefaults.register(defaults: defaultValues)
        
        hideKeyboardWhenTappedAround()
        
        gCompanyName = QuoteDefaults.string(forKey: "dCompanyName")!
        gAddress = QuoteDefaults.string(forKey: "dAddress")!
        gState = QuoteDefaults.string(forKey: "dState")!
        gZip = QuoteDefaults.string(forKey: "dZip")!
        gCountry = QuoteDefaults.string(forKey: "dCountry")!
        gPhone = QuoteDefaults.string(forKey: "dPhone")!
        
        gFirstName = QuoteDefaults.string(forKey: "dFirstName")!
        gLastName = QuoteDefaults.string(forKey: "dLastName")!
        gJobTitle = QuoteDefaults.string(forKey: "dJobTitle")!
        gEmail = QuoteDefaults.string(forKey: "dEmail")!
    
        ShowValidCheckMarks()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
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

