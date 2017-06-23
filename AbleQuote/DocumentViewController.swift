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
    
    @IBAction func Done(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Filename.layer.borderColor = UIColor.black.cgColor
        Filename.layer.borderWidth = 1.0

    }
   
    @IBAction func handleImportMenuPressed(_ sender: AnyObject) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as NSString as String], in: .import)
     
        importMenu.delegate = self
        importMenu.addOption(withTitle: "Create New Document", image: nil, order: .first, handler: { print("New Doc Requested") })
        present(importMenu, animated: false, completion: nil)
    }
    
    @IBAction func handleImportPickerPressed(_ sender: AnyObject) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as NSString as String, kUTTypeContent as NSString as String], in: .import)
        
        documentPicker.delegate = self
        present(documentPicker, animated: false, completion: nil)
    }
    
    //next func not used
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print(url)
      
        let absString: String = url.absoluteString
        print(absString)
        let relString: String = url.relativeString
        print(relString)
        let relPath: String = url.relativePath
        print(relPath)
        let Path: String = url.path
        print(Path)
      
        gFilename = (Path as NSString).lastPathComponent
        Filename.text = gFilename
        gFullPath = Path
    }
}
