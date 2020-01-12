//
//  SignUpViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/8/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.contentHorizontalAlignment = .center
        usernameTextField.contentHorizontalAlignment = .center
        passwordTextField.contentHorizontalAlignment = .center
        repeatPasswordTextField.contentHorizontalAlignment = .center
        // Do any additional setup after loading the view.
    }
    

    //MARK: Actions
    @IBAction func didCreateAccount(_ sender: UIButton) {
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
        
        guard let username = usernameTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Username cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if username == "" {
            let alert = UIAlertController(title: "Error", message: "Username cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard password.count >= 6 else {
            let alert = UIAlertController(title: "Error", message: "Password has to contain at least 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let repeatPassword = repeatPasswordTextField.text else {
            let alert = UIAlertController(title: "Error", message: "Repeated password cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        if repeatPassword == "" {
            let alert = UIAlertController(title: "Error", message: "Repeated password cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard repeatPassword == password else {
            let alert = UIAlertController(title: "Error", message: "Password doesn't match repeated password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        //create an account on Firebase
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let userId = user?.user.uid else { return }
            let values = ["email": email, "username": self.usernameTextField.text!, "preference": "N/A"] as [String : Any]
            let ref = Database.database().reference().child("users").child(userId)
            ref.updateChildValues(values) { (error, ref) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                print("Successfully sign up")
                let alert = UIAlertController(title: "Success", message: "Account created", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    self.performSegue(withIdentifier: "unwindFromCreatedAccount", sender: self)
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }
        
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
