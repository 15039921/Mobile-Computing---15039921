//
//  NameViewController.swift
//  
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//
import UIKit

class NameViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var nameTxt : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text! == ""
        {
            return false
        }
        
        UserDefaults.standard.setValue(nameTxt.text!, forKey: "name")
        
        self.performSegue(withIdentifier: "next", sender: nil)
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
