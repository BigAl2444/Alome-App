//
//  ViewController.swift
//  Alome
//
//  Created by student on 29/5/18.
//  Copyright © 2018 student. All rights reserved.
//
import UIKit
import FirebaseDatabase //allows me to connect to firebase
import AVFoundation     //alows xcode to use audio files

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var lockSound: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {   //runs when the app is loaded
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let lockSoundPath = Bundle.main.path(forResource: "iPhoneLock", ofType: ".mp3") //sets lockpath to iPhone.mp3
        do {
            try lockSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: lockSoundPath!)) //lockSound now is the Audio File
        }
        catch {
            print(error)
        }
      
        // The next 19 lines of code run when a variable is added to the database or when the app is lunched
        ref?.child("house").observe(.childAdded, with: {(snapshot) in //snapshot store all of the data from the database when a variable is added
            let doorKey = snapshot.key  // this is the name of the variable added to firebase
            let doorPosition = snapshot.value as? Bool  // this is the value of varible
            
            if doorKey == "door1Position" { // if the variable name from firebase equals door1Position the below code will run
                if doorPosition == true{    // if the variable from firebase equals true that means the door is closed
                    self.frontDoorPosition.image = UIImage(named: "doorClosed") // Sets the frontdoor, door icon to show a closed door
                } else{
                    self.frontDoorPosition.image = UIImage(named: "doorOpen")   // Sets the frontdoor, door icon to show an opened door
                }
            }
            
            if doorKey == "door2Position" { // if the variable name from firebase equals door2Position the below code will run
                if doorPosition == true{    // if the variable from firebase equals true that means the door is closed
                    self.backDoorPosition.image = UIImage(named: "doorClosed")  // Sets the backdoor, door icon to show a closed door
                } else{
                    self.backDoorPosition.image = UIImage(named: "doorOpen")    // Sets the backdoor, door icon to show an opened door
                }
            }
        })
        // The next 19 lines of code run when a variable is changed/updated on the database or when the app is lunched
        ref?.child("house").observe(.childChanged, with: {(snapshot) in //snapshot store all of the data from the database when a variable is changed/updated
            let doorKey = snapshot.key
            let doorPosition = snapshot.value as? Bool
            
            if doorKey == "door1Position" { // if the variable name from firebase equals door1Position the below code will run
                if doorPosition == true{    // if the variable from firebase equals true that means the door is closed
                    self.frontDoorPosition.image = UIImage(named: "doorClosed") // Sets the backdoor, door icon to show a closed door
                } else{
                    self.frontDoorPosition.image = UIImage(named: "doorOpen")   // Sets the backdoor, door icon to show an opened door
                }
            }
            
            if doorKey == "door2Position" { // if the variable name from firebase equals door2Position the below code will run
                if doorPosition == true{    // if the variable from firebase equals true that means the door is closed
                    self.backDoorPosition.image = UIImage(named: "doorClosed")  // Sets the backdoor, door icon to show a closed door
                } else{
                    self.backDoorPosition.image = UIImage(named: "doorOpen")    // Sets the backdoor, door icon to show an opened door
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var frontDoorLock: UIImageView!
    
    @IBOutlet weak var backDoorLock: UIImageView!
    
    @IBOutlet weak var frontDoorPosition: UIImageView!

    @IBOutlet weak var backDoorPosition: UIImageView!
    
    var timer = Timer() // timer variable used to delay 4s seconds before locking the door again
    
    @IBAction func frontDoor(_ sender: UIButton) {  // this funtion is called when the front door button is pressed
        frontDoorLock.image = UIImage(named: "unlock")  // sets the front door lock icon to an unlocked icon
        ref?.child("house").child("door1").setValue(true)   // updates the database so the arduino knows to unlock the houses front door
        lockSound.play()    // Plays lock sound
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor1), userInfo: nil, repeats:false)// delays 4 seconds before calling the lockDoor1 function
    }
    
    @IBAction func backDoor(_ sender: UIButton) { // this funtion is called when the back door button is pressed
         backDoorLock.image = UIImage(named: "unlock")  // sets the back door lock icon to an unlocked icon
        ref?.child("house").child("door2").setValue(true) // updates the database so the arduino knows to unlock the houses back door
        lockSound.play()    // Plays lock sound
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor2), userInfo: nil, repeats:false)// delays 4 seconds calling the lockDoor2 function
    }
    
    @objc func lockDoor1(){ // This functionis called 4 seconds after the front door is unlocked
        ref?.child("house").child("door1").setValue(false)  // sets the database variable to locked so the arduino knows to lock the door
        frontDoorLock.image = UIImage(named: "lock-icon")  // sets the front door lock icon to a locked icon
        lockSound.play()    // Plays lock sound
    }
    
    @objc func lockDoor2(){ // This functionis called 4 seconds after the back door is unlocked
        ref?.child("house").child("door2").setValue(false) // sets the database variable to locked so the arduino knows to lock the door
        backDoorLock.image = UIImage(named: "lock-icon")    // sets the back door lock icon to a locked icon
        lockSound.play()    // Plays lock sound
    }
    
}


