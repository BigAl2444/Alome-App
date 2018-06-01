//
//  ViewControllerLogin.swift
//  Alome
//
//  Created by student on 1/6/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController {
    
    

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
            
            
            
            //Define the email an password variables with the data that is inside the fields that reference with themselves
            
            let email = emailText.text
            
            let password = passwordText.text
            
            
            
            //Authenticate and login with firebase
            
            Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                
                //Check if there is and error and perform each path
                
                if let error = error {
                    
                    //Present the error alert
                    
                    print(error)
                    
                } else {
                    
                    //Successful Login
                    
                    print("Successful Login")
                    
                    //Segue to the next view controller
                    
                    self.performSegue(withIdentifier: "toMainPage", sender: nil)
                    
                }
                
            }
            
        }
        
        
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
