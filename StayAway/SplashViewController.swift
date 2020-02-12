

import UIKit
import AVFoundation

class SplashViewController: UIViewController {

    @IBOutlet weak var splashImage: UIImageView!
   
    var heliSound:NSURL=NSURL()
    var audioPlayer:AVAudioPlayer=AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image: UIImage = UIImage.gif(name: "armyheli")!
        splashImage.image=image
        
         heliSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "helimusic", ofType: "mp3")!)
        do {
       try audioPlayer = AVAudioPlayer(contentsOf: heliSound as URL)
            audioPlayer.volume=0.4
        } catch {
            
            print("Problem in getting File")
            
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        
        
        UIView.animate(withDuration: 1, delay: 6, options: .curveEaseOut,
                        animations: { () -> Void in
                            self.splashImage.alpha = 0.4 },
                        completion: { _ in
                            self.goToNext() })
    }
    func goToNext(){
      
     audioPlayer.stop()
        DispatchQueue.main.async
            {
               
                self.performSegue(withIdentifier: "home", sender: self)
                
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
