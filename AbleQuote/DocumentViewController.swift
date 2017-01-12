//
//  Document ViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/12/17.
//  Copyright © 2017 Able. All rights reserved.
//
import UIKit
import MobileCoreServices

class Document_ViewController: UIViewController, UIDocumentMenuDelegate, UIDocumentPickerDelegate {
    
    @IBAction func Done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handleImportMenuPressed(self)
        //handleImportPickerPressed(self)
        //importPicker()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    @IBAction func handleImportMenuPressed(sender: AnyObject) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String], inMode: .Import)
     
        importMenu.delegate = self
        importMenu.addOptionWithTitle("Create New Document", image: nil, order: .First, handler: { print("New Doc Requested") })
        presentViewController(importMenu, animated: true, completion: nil)
    }
    /*
    func importPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as NSString as String], inMode: .Import)
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    */
    
    @IBAction func handleImportPickerPressed(sender: AnyObject) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as NSString as String], inMode: .Import)
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    // MARK:- UIDocumentMenuDelegate
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    // MARK:- UIDocumentPickerDelegate
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        // Do something
        print(url)
    }
    
    
}
