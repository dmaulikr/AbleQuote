//
//  CompanyViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/8/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var WeAre = ["Original Equipment Mfg", "Manufacturer/Supplier", "Metalworking House", "Job Shop"];

    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtZip: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var WeArePicker: UIPickerView!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func CancelCompany(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func DoneCompany(sender: AnyObject) {
        
        if txtCompanyName.text! == "" {
            let alertController = UIAlertController(title: "Missing Company Name", message: "Company Name is a required field", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            if txtAddress.text! == "" {
                let alertController = UIAlertController(title: "Missing Address", message: "Address is a required field", preferredStyle: .Alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                if txtState.text == "" {
                    let alertController = UIAlertController(title: "Missing State", message: "State is a required field", preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
                    alertController.addAction(defaultAction)
                    presentViewController(alertController, animated: true, completion: nil)
                }
                else {
                    if txtZip.text! == "" {
                        let alertController = UIAlertController(title: "Missing Zip Code", message: "Zip Code is a required field", preferredStyle: .Alert)
                        let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        presentViewController(alertController, animated: true, completion: nil)
                    }
                    else {
                        if txtCountry.text == "" {
                            let alertController = UIAlertController(title: "Missing Country", message: "Country is a required field", preferredStyle: .Alert)
                            let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
                            alertController.addAction(defaultAction)
                            presentViewController(alertController, animated: true, completion: nil)
                        }
                        else {
                            if txtPhone.text! == "" {
                                let alertController = UIAlertController(title: "Missing Phone number", message: "Phone number is a required field", preferredStyle: .Alert)
                                let defaultAction = UIAlertAction(title: "Close Alert", style: .Default, handler: nil)
                                alertController.addAction(defaultAction)
                                presentViewController(alertController, animated: true, completion: nil)
                            }
                            else {
                                gCompanyName = txtCompanyName.text!
                                gAddress = txtAddress.text!
                                gState = txtState.text!
                                gZip = txtZip.text!
                                gCountry = txtCountry.text!
                                gPhone = txtPhone.text!
                                
                                gCompanyValid = true
                                
                                QuoteDefaults.setObject(gCompanyName, forKey: "dCompanyName")
                                QuoteDefaults.setObject(gAddress, forKey: "dAddress")
                                QuoteDefaults.setObject(gState, forKey: "dState")
                                QuoteDefaults.setObject(gZip, forKey: "dZip")
                                QuoteDefaults.setObject(gCountry, forKey: "dCountry")
                                QuoteDefaults.setObject(gPhone, forKey: "dPhone")
        
                                dismissViewControllerAnimated(true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.WeArePicker.delegate = self
        self.WeArePicker.dataSource = self
        self.WeArePicker.selectRow(gWeArePickerIndex, inComponent: 0, animated: true)
        
        txtAddress.layer.borderColor = UIColor.blackColor().CGColor //set your color here
        txtAddress.layer.borderWidth = 1.0
        
        gCompanyName = QuoteDefaults.stringForKey("dCompanyName")!
        gAddress = QuoteDefaults.stringForKey("dAddress")!
        gState = QuoteDefaults.stringForKey("dState")!
        gZip = QuoteDefaults.stringForKey("dZip")!
        gCountry = QuoteDefaults.stringForKey("dCountry")!
        gPhone = QuoteDefaults.stringForKey("dPhone")!
        
        txtCompanyName.text! = gCompanyName
        txtAddress.text! = gAddress
        txtState.text! = gState
        txtZip.text! = gZip
        txtCountry.text! = gCountry
        txtPhone.text! = gPhone

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WeAre.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return WeAre[row]  //pickerDataSource[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gWeArePickerIndex = row
        gWeArePicker = (WeAre[row])
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CompanyViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CompanyViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
