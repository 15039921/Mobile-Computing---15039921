//
//  GameViewController.swift
//  
//  game_Project
//
//  Created by Shivam  patel on (17/06/2019).
//  Copyright © 2019 Shivam . All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController , ScoreDelegate{
    
    @IBOutlet weak var scoreLbl : UILabel!
    @IBOutlet weak var timeLbl : UILabel!
    
    var audioPlayer = AVAudioPlayer()
    
    var scene: GameScene!
    
    var seconds = 20 {
        didSet{
            //set time on screen
            timeLbl.text = "\(seconds)"
        }
    }
    
    var timer = Timer()
    
    var score = 0 {
        didSet{
            //set score on screen.
            scoreLbl.text = "\(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        skView.showsPhysics = true
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.scoreDelegate = self
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
    
    @IBAction func palyPuase(_ sender: UIButton)
    {
        if sender.tag == 0
        {
            sender.setBackgroundImage(UIImage(named: "puase"), for: .normal)
            sender.tag = 1
            audioPlayer.pause()
            scene.view?.isPaused = true
            timer.invalidate()
        }else{
            sender.setBackgroundImage(UIImage(named: "play-1"), for: .normal)
            sender.tag = 0
            audioPlayer.play()
            scene.view?.isPaused = false
            runTimer()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            audioPlayer.stop()
            
            if let high = UserDefaults.standard.value(forKey: "high") as? Int{
                if high < score
                {
                    UserDefaults.standard.set(score, forKey: "high")
                }
            }else{
                UserDefaults.standard.set(score, forKey: "high")
            }
            
            // passing scores to next activity
            score = scene.score
            print("scorevc\(score)")
            
            let myVC = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            myVC.final_score = score
            //navigationController?.pushViewController(myVC, animated: true)
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
    
    func didUpdateScore(score: Int) {
        self.score = score
    }
    
    func didHitCrow() {
        timer.invalidate()
        audioPlayer.stop()
        
        if let high = UserDefaults.standard.value(forKey: "high") as? Int{
            if high < score
            {
                UserDefaults.standard.set(score, forKey: "high")
            }
        }else{
            UserDefaults.standard.set(score, forKey: "high")
        }
        
        // passing scores to next activity
        score = scene.score
        print("scorevc\(score)")
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        myVC.final_score = score
        //navigationController?.pushViewController(myVC, animated: true)
        self.present(myVC, animated: false, completion: nil)
    }
}
