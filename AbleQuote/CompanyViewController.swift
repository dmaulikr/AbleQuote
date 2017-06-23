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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func CancelCompany(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneCompany(_ sender: AnyObject) {
        
        if txtCompanyName.text! == "" {
            let alertController = UIAlertController(title: "Missing Company Name", message: "Company Name is a required field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            if txtAddress.text! == "" {
                let alertController = UIAlertController(title: "Missing Address", message: "Address is a required field", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
            else {
                if txtState.text == "" {
                    let alertController = UIAlertController(title: "Missing State", message: "State is a required field", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                }
                else {
                    if txtZip.text! == "" {
                        let alertController = UIAlertController(title: "Missing Zip Code", message: "Zip Code is a required field", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        present(alertController, animated: true, completion: nil)
                    }
                    else {
                        if txtCountry.text == "" {
                            let alertController = UIAlertController(title: "Missing Country", message: "Country is a required field", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            present(alertController, animated: true, completion: nil)
                        }
                        else {
                            if txtPhone.text! == "" {
                                let alertController = UIAlertController(title: "Missing Phone number", message: "Phone number is a required field", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                present(alertController, animated: true, completion: nil)
                            }
                            else {
                                gCompanyName = txtCompanyName.text!
                                gAddress = txtAddress.text!
                                gState = txtState.text!
                                gZip = txtZip.text!
                                gCountry = txtCountry.text!
                                gPhone = txtPhone.text!
                                //gWeArePicker = pickerView(WeArePicker, didSelectRow: <#T##Int#>, inComponent: <#T##Int#>), inComponent: <#T##Int#>, animated: <#T##Bool#>
                                
                                
                                gCompanyValid = true
                                
                                QuoteDefaults.set(gCompanyName, forKey: "dCompanyName")
                                QuoteDefaults.set(gAddress, forKey: "dAddress")
                                QuoteDefaults.set(gState, forKey: "dState")
                                QuoteDefaults.set(gZip, forKey: "dZip")
                                QuoteDefaults.set(gCountry, forKey: "dCountry")
                                QuoteDefaults.set(gPhone, forKey: "dPhone")
        
                                dismiss(animated: true, completion: nil)
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
        
        //self.WeArePicker.selectRow(gWeArePickerIndex, inComponent: 0, animated: true)
        
        txtAddress.layer.borderColor = UIColor.black.cgColor //set your color here
        txtAddress.layer.borderWidth = 1.0
        
        gCompanyName = QuoteDefaults.string(forKey: "dCompanyName")!
        gAddress = QuoteDefaults.string(forKey: "dAddress")!
        gState = QuoteDefaults.string(forKey: "dState")!
        gZip = QuoteDefaults.string(forKey: "dZip")!
        gCountry = QuoteDefaults.string(forKey: "dCountry")!
        gPhone = QuoteDefaults.string(forKey: "dPhone")!
        gWeArePickerIndex = QuoteDefaults.integer(forKey: "dWeArePickerIndex")
        
        txtCompanyName.text! = gCompanyName
        txtAddress.text! = gAddress
        txtState.text! = gState
        txtZip.text! = gZip
        txtCountry.text! = gCountry
        txtPhone.text! = gPhone
        WeArePicker.selectRow(gWeArePickerIndex, inComponent: gWeArePickerIndex, animated: true)
        //self.WeArePicker.selectRow(gWeArePickerIndex, inComponent: gWeArePickerIndex, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WeAre.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return WeAre[row]  //pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
