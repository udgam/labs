//
//  HomeViewController.swift
//
//
//  Created by Udgam Goyal on 6/21/16.
//
//

import UIKit
import Parse

class HomeViewController: UIViewController {
    
    var alertController: UIAlertController!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginAction(sender: AnyObject)
    {
        
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!, block: { (user: PFUser?, error: NSError?) in
            if user != nil{
                print("Found User")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            if  true {
                self.alertController = UIAlertController(title: "Invalid Username", message: "Please Try Again", preferredStyle: .Alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                self.alertController.addAction(OKAction)
                
                self.presentViewController(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
            }
        })
    }
    
    
    @IBAction func signUpAction(sender: AnyObject)
    {
        
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?)-> Void in
            if success{
                print("User created")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
            else {
                print(error?.localizedDescription)
                self.alertController = UIAlertController(title: "Username Taken", message: "Please Try Again", preferredStyle: .Alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                self.alertController.addAction(OKAction)
                
                self.presentViewController(self.alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
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
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
