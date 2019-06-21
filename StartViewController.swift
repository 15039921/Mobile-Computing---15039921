//
//  StartViewController.swift
//  
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//
import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var score : UILabel!
    @IBOutlet weak var nameLbl : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let high = UserDefaults.standard.value(forKey: "high") as? Int{
            score.text = "\(high)"
        }
        
        nameLbl.text = UserDefaults.standard.value(forKey: "name") as? String
        // Do any additional setup after loading the view.
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
