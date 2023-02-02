//
//  ViewController.swift
//  MyEggTimer
//
//  Created by Egor Naberezhnov on 28.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft": 300, "Medium": 480, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var titleF: UILabel!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.titleLabel?.text
        totalTime = eggTime[hardness!]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleF.text = hardness

        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()

    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)

            print(progressBar.progress)
        } else {
            timer.invalidate()
            titleF.text = "Done"
            playSound()
        }
    }
    


}

