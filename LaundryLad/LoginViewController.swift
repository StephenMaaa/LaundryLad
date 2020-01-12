//
//  LoginViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/8/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction func didLogin(_ sender: UIButton) {
        //check validity
        guard let email = emailTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Email cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if email == "" {
           let alert = UIAlertController(title: "Error", message: "Email cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Password cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if password == "" {
            let alert = UIAlertController(title: "Error", message: "Password cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        //log in
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "Email is not found or password is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let alert = UIAlertController(title: "Success", message: "Account created", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
                //self.performSegue(withIdentifier: "loginAccount", sender: self)
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromCreatedAccount(_ sender: UIStoryboardSegue) {
        guard let sourceController = sender.source as? SignUpViewController else {
            fatalError("Unexpected controller \(sender.source)")
        }
        emailTextField.text = sourceController.emailTextField.text
        passwordTextField.text = sourceController.passwordTextField.text
    }
    
    @IBAction func unwindToLogin(_ sender: UIStoryboardSegue) {
        guard let sourceController = sender.source as? SignUpViewController else {
            fatalError("Unexpected controller \(sender.source)")
        }
        //do nothing here
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
