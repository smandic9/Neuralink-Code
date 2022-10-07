//
//  ChildGameViewController.swift
//  Connect
//
//  Created by Sara Mandic on 2/1/20.
//  Copyright © 2020 hacksc. All rights reserved.
//
import UIKit

class ChildGameViewController: UIViewController{
    var s=0
    var t:Timer?
    var seconds=60


    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScore()
        updateNumber()
        updateTimer()
        //print("View did load")
        // Do any additional setup after loading the view.
    }
    func updateScore(){
        score?.text=String(s)
    }
    func updateNumber(){
        number?.text=String.randomNumber(length:3)
    }
    func updateTimer(){
        let min=(seconds/60)%60
        let sec=seconds%60
        
        timer?.text=String(format: "%02d", min) +  ":" + String(format: "%02d", sec)
    }
    @IBAction func filechange(){
        guard let numberText=number?.text, let inputText=input?.text else{
            return
        }
        guard inputText.count==3 else{
                return
        }
        var num=Int(numberText)
        var inp=Int(inputText)
        if (num! == (inp! - 5)){
            s+=10
        }
        else{
            s-=1
        }
        
        updateNumber()
        updateScore()
        input?.text = ""
        
        if t==nil{
            t=Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){t in
                if self.seconds==0{
                    self.finishGame()
                }
                if (self.seconds <= 60){
                    self.seconds-=1
                    self.updateTimer()
                }
            }
        }
    }
    
    func finishGame(){
        t?.invalidate()
        t=nil
        let alert=UIAlertController(title: "Time's Up!", message: "Your score was " + String(s), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Great job, start new game" , style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        s=0
        seconds=60
        updateTimer()
        updateScore()
        updateNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
