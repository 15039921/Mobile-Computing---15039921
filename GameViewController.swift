//
//  GameViewController.swift
//  game_Project
//
//  Created by SHIVAM PATEL on (26/12/2018).
//  Copyright © 2019 SHIVAM. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    var scene: GameScene!
    var seconds = 20
    var timer = Timer()
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        skView.showsPhysics = true
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        // runtimer is the function which count down for 20 sec to move to next activity which has button replay
        
        runTimer()
        do{
            // initialize sound file
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:  Bundle.main.path(forResource: "spy", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
        catch{
            print(error)
        }
        
       
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            audioPlayer.stop()
            // passing scores to next activity
            score = scene.score
            print("scorevc\(score)")
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as UIViewController
            let myVC = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            myVC.final_score = score
            navigationController?.pushViewController(myVC, animated: true)
            self.present(myVC, animated: false, completion: nil)
            
            
        } else {
            seconds -= 1
        }
    }
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
