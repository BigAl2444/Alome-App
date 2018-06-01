//
//  ViewController.swift
//  Alome
//
//  Created by student on 29/5/18.
//  Copyright © 2018 student. All rights reserved.
//
import UIKit
import FirebaseDatabase
class ViewController: UIViewController {
    
    
    
    
    
    var ref: DatabaseReference!
 /*   let smartDevices = ["Front Door","Back Door"]
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (smartDevices.count)
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "mainTable")
        cell.textLabel?.text = smartDevices[indexPath.row]
        return (cell)
 }
 
 */
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var frontDoorLock: UIImageView!
    
    @IBOutlet weak var backDoorLock: UIImageView!
    var timer = Timer()
    @IBAction func frontDoor(_ sender: UIButton) {
        frontDoorLock.image = UIImage(named: "unlock")
        ref?.child("house").child("door1").setValue(true)
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor1), userInfo: nil, repeats:false)

    }
    
    @objc func lockDoor1(){
        ref?.child("house").child("door1").setValue(false)
        frontDoorLock.image = UIImage(named: "lock-icon")
        
    }
    @objc func lockDoor2(){
        ref?.child("house").child("door2").setValue(false)
        backDoorLock.image = UIImage(named: "lock-icon")
        
    }
    
    @IBAction func backDoor(_ sender: UIButton) {
         backDoorLock.image = UIImage(named: "unlock")
        ref?.child("house").child("door2").setValue(true)
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.lockDoor2), userInfo: nil, repeats:false)
    }
}


