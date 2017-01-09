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
    
    @IBAction func DoneParts(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.InterestedInPicker.delegate = self
        self.InterestedInPicker.dataSource = self
        self.InterestedInPicker.selectRow(0, inComponent: 0, animated: true)
        
        txtReason.layer.borderColor = UIColor.blackColor().CGColor //set your color here
        txtReason.layer.borderWidth = 1.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return InterestedIn.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return InterestedIn[row]  //pickerDataSource[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.WeArePicker.text = (WeAre[row])
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
