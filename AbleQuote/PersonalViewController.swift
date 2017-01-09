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

    @IBAction func DonePersonal(sender: AnyObject) {
        gFirstName = txtFirstName.text!
        gLastName = txtLastName.text!
        gJobTitle = txtJobTitle.text!
        gEmail = txtEmail.text!
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension PersonalViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PersonalViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
