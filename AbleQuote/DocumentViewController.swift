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
    
    @IBOutlet weak var Filename: UITextView!
    
    @IBAction func Done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func handleImportMenuPressed(sender: AnyObject) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String], inMode: .Import)
     
        importMenu.delegate = self
        importMenu.addOptionWithTitle("Create New Document", image: nil, order: .First, handler: { print("New Doc Requested") })
        presentViewController(importMenu, animated: false, completion: nil)
    }
    
    @IBAction func handleImportPickerPressed(sender: AnyObject) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as NSString as String, kUTTypeContent as NSString as String], inMode: .Import)
        
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: false, completion: nil)
    }
    
    //next func not used
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }

    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        print(url)
      
        let absString: String = url.absoluteString!
        print(absString)
        let relString: String = url.relativeString
        print(relString)
        let relPath: String = url.relativePath!
        print(relPath)
        let Path: String = url.path!
        print(Path)
      
        gFilename = (Path as NSString).lastPathComponent
        Filename.text = gFilename
        gFullPath = Path
    }
}
