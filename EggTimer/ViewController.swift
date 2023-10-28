import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       }

       @objc func updateCounter() {
           //example functionality
           if secondPassed < totalTime {
               secondPassed += 1
               progressBar.progress = Float(secondPassed) / Float(totalTime)
           } else {
               timer.invalidate()
               titleLabel.text = "DONE!"
               
               let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
               player = try! AVAudioPlayer(contentsOf: url!)
               player.play()
           }
       }
}
