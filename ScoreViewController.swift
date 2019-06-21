//
//  ScoreViewController.swift
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var final_score = 0
    
    
    @IBOutlet var score_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        score_label.text = String(final_score)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
