//
//  ViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/5/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit
import MessageUI

var gCompanyName = ""
var gAddress = ""
var gState = ""
var gZip = ""
var gCountry = ""
var gPhone = ""
var gWeArePicker = ""

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

class ViewController: UIViewController,MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate  {

    @IBAction func TakePhoto(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func SelectPhoto(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        MyImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var MyImageView: UIImageView!
    
    @IBAction func composeEmail(sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
        
            let picker = MFMailComposeViewController()
        
            picker.mailComposeDelegate = self
            picker.setToRecipients(["jscoltock3@gmail.com"])
            picker.setMessageBody("<b>Request for Quote from Able Electropolishing</b>", isHTML: true)
            picker.setSubject("Request for Quote")
            
            //let testimage = MyImageView.image
            //let orientedImage = UIImage(CGImage: testimage!.CGImage!, scale: 1, orientation: testimage!.imageOrientation)
            //let imageData: NSData = UIImagePNGRepresentation(orientedImage)!

            let imageData: NSData = UIImagePNGRepresentation(MyImageView.image!)!
            
            picker.addAttachmentData(imageData, mimeType: "image/jpg", fileName: "QuotePart.jpg")
            
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
        }
    }
    
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

