//
//  ScoreViewController.swift
//  game_Project
//
//  Created by SAM on 04/01/2019.
//  Copyright © 2019 SAM. All rights reserved.
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
