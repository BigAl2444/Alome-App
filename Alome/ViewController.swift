//
//  ViewController.swift
//  Alome
//
//  Created by student on 29/5/18.
//  Copyright © 2018 student. All rights reserved.
//
import UIKit
import FirebaseDatabase
import AVFoundation

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var lockSound: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let lockSoundPath = Bundle.main.path(forResource: "iPhoneLock", ofType: ".mp3")
        do {
            try lockSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: lockSoundPath!))
        }
        catch {
            print(error)
        }
        
        ref?.child("house").observe(.childAdded, with: {(snapshot) in
            let doorKey = snapshot.key
            let doorPosition = snapshot.value as? Bool
            if doorKey == "door1Position" {
                if doorPosition == true{
                    self.frontDoorPosition.image = UIImage(named: "doorClosed")
                } else{
                    self.frontDoorPosition.image = UIImage(named: "doorOpen")
                }
            }
            if doorKey == "door2Position" {
                if doorPosition == true{
                    self.backDoorPosition.image = UIImage(named: "doorClosed")
                } else{
                    self.backDoorPosition.image = UIImage(named: "doorOpen")
                }
            }
            
            // This code to executes whem the data is changed
        })
        ref?.child("house").observe(.childChanged, with: {(snapshot) in
            let doorKey = snapshot.key
            let doorPosition = snapshot.value as? Bool
            if doorKey == "door1Position" {
                if doorPosition == true{
                    self.frontDoorPosition.image = UIImage(named: "doorClosed")
                } else{
                    self.frontDoorPosition.image = UIImage(named: "doorOpen")
                }
            }
            if doorKey == "door2Position" {
                if doorPosition == true{
                    self.backDoorPosition.image = UIImage(named: "doorClosed")
                } else{
                    self.backDoorPosition.image = UIImage(named: "doorOpen")
                }
            }
            
            // This code to executes whem the data is changed
        })
       
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var frontDoorLock: UIImageView!
    
    @IBOutlet weak var backDoorLock: UIImageView!
    
    @IBOutlet weak var frontDoorPosition: UIImageView!

    @IBOutlet weak var backDoorPosition: UIImageView!
    
    var timer = Timer()
    @IBAction func frontDoor(_ sender: UIButton) {
        frontDoorLock.image = UIImage(named: "unlock")
        ref?.child("house").child("door1").setValue(true)
        lockSound.play()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor1), userInfo: nil, repeats:false)

    }
    
    @objc func lockDoor1(){
        ref?.child("house").child("door1").setValue(false)
        frontDoorLock.image = UIImage(named: "lock-icon")
        lockSound.play()
        
    }
    @objc func lockDoor2(){
        ref?.child("house").child("door2").setValue(false)
        backDoorLock.image = UIImage(named: "lock-icon")
        lockSound.play()
        
    }
    
    @IBAction func backDoor(_ sender: UIButton) {
         backDoorLock.image = UIImage(named: "unlock")
        ref?.child("house").child("door2").setValue(true)
        lockSound.play()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor2), userInfo: nil, repeats:false)
    }
}


