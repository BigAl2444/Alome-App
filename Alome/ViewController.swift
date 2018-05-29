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

    @IBAction func frontDoor(_ sender: UIButton) {
        ref?.child("house").child("door1").setValue(true)
        sleep(4)
        ref?.child("house").child("door1").setValue(false)
    }
    @IBAction func backDoor(_ sender: UIButton) {
        ref?.child("house").child("door2").setValue(true)
        sleep(4)
        ref?.child("house").child("door2").setValue(false)
    }
}
