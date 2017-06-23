//
//  PartsViewController.swift
//  AbleQuote
//
//  Created by James Scoltock on 1/8/17.
//  Copyright © 2017 Able. All rights reserved.
//

import UIKit

class PartsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var InterestedIn = ["Electropolishing", "Passivation", "Titanium Andodizing", "Laser Marking/Engraving", "Degreasing"];
    
    @IBOutlet weak var txtLotSizes: UITextField!
    @IBOutlet weak var txtAnnualVolume: UITextField!
    @IBOutlet weak var txtMaterialType: UITextField!
    @IBOutlet weak var txtPriorOperation: UITextField!
    @IBOutlet weak var txtReason: UITextView!
    @IBOutlet weak var InterestedInPicker: UIPickerView!
    
    @IBAction func CancelParts(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func DoneParts(_ sender: AnyObject){
        if txtLotSizes.text! == "" {
            let alertController = UIAlertController(title: "Missing Lot Sizes", message: "Lot sizes is a required field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            if txtAnnualVolume.text! == "" {
                let alertController = UIAlertController(title: "Missing Annual Volume", message: "Annual Volume is a required field", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
            else {
                if txtMaterialType.text == "" {
                    let alertController = UIAlertController(title: "Missing Material Type", message: "Material Type is a required field", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    present(alertController, animated: true, completion: nil)
                }
                else {
                    if txtPriorOperation.text! == "" {
                        let alertController = UIAlertController(title: "Missing Prior Operation", message: "Prior Operation is a required field", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        present(alertController, animated: true, completion: nil)
                    }
                    else {
                        if txtReason.text == "" {
                            let alertController = UIAlertController(title: "Missing Primary Reason", message: "Primary Reason is a required field", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            present(alertController, animated: true, completion: nil)
                        }
                        else {
                            gLotSizes = txtLotSizes.text!
                            gAnnualVolume = txtAnnualVolume.text!
                            gMaterialType = txtMaterialType.text!
                            gPriorOperation = txtPriorOperation.text!
                            gReason = txtReason.text!
                            
                            gPartsValid = true

                            dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.InterestedInPicker.delegate = self
        self.InterestedInPicker.dataSource = self
        self.InterestedInPicker.selectRow(gInterestedInPickerIndex, inComponent: 0, animated: true)
        
        txtReason.layer.borderColor = UIColor.black.cgColor //set your color here
        txtReason.layer.borderWidth = 1.0
        
        txtLotSizes.text! = gLotSizes
        txtAnnualVolume.text! = gAnnualVolume
        txtMaterialType.text! = gMaterialType
        txtPriorOperation.text! = gPriorOperation
        txtReason.text! = gReason
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InterestedIn.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InterestedIn[row]  //pickerDataSource[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gInterestedInPicker = (InterestedIn[row])
        gInterestedInPickerIndex = row
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


extension PartsViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PartsViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
