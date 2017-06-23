//
//  PersonalViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/8/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBAction func Cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func DonePersonal(_ sender: AnyObject) {
        
        if txtFirstName.text! == "" {
            let alertController = UIAlertController(title: "Missing First Name", message: "First Name is a required field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            if txtLastName.text! == "" {
                let alertController = UIAlertController(title: "Missing Last Name", message: "Last Name is a required field", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
            else {
                if txtJobTitle.text == "" {
                    let alertController = UIAlertController(title: "Missing Job Title", message: "Job Title is a required field", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                }
                else {
                    if txtEmail.text! == "" {
                        let alertController = UIAlertController(title: "Missing Email", message: "Email is a required field", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        present(alertController, animated: true, completion: nil)
                    }
                    else {
                       if isValidEmail(txtEmail.text!) || txtEmail.text == "" {
                            gFirstName = txtFirstName.text!
                            gLastName = txtLastName.text!
                            gJobTitle = txtJobTitle.text!
                            gEmail = txtEmail.text!
                        
                            gPersonalValid = true
                        
                            QuoteDefaults.set(gFirstName, forKey: "dFirstName")
                            QuoteDefaults.set(gLastName, forKey: "dLastName")
                            QuoteDefaults.set(gJobTitle, forKey: "dJobTitle")
                            QuoteDefaults.set(gEmail, forKey: "dEmail")
                        
                            dismiss(animated: true, completion: nil)
                        }
                        else
                        {
                            gPersonalValid = false
                            let alertController = UIAlertController(title: "Invalid Email", message:
                                "Email address is not valid. Try again!", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        gFirstName = QuoteDefaults.string(forKey: "dFirstName")!
        gLastName = QuoteDefaults.string(forKey: "dLastName")!
        gJobTitle = QuoteDefaults.string(forKey: "dJobTitle")!
        gEmail = QuoteDefaults.string(forKey: "dEmail")!

        txtFirstName.text! = gFirstName
        txtLastName.text! = gLastName
        txtJobTitle.text! = gJobTitle
        txtEmail.text! = gEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PersonalViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

func isValidEmail(_ testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let range = testStr.range(of: emailRegEx, options:.regularExpression)
    let result = range != nil ? true : false
    return result
}


