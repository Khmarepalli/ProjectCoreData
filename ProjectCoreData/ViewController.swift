//
//  ViewController.swift
//  ProjectCoreData
//
//  Created by Krishna Marepalli on 1/15/19.
//  Copyright © 2019 Krishna Marepalli. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Hello")
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        if usernameTextField.text != nil || passwordTextField != nil || usernameTextField.text != "" || passwordTextField.text != ""{
            retrieveData()
        }
        else{
            let alert = UIAlertController(title: "Try Again", message: "Wrong username or password.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)})
        }
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
    
    
    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                if usernameTextField.text == data.value(forKey: "username") as! String && passwordTextField.text == data.value(forKey: "password") as! String
                {
                    print("Gucci")
                    performSegue(withIdentifier: "signInSegue", sender: self)
                    
                }
                else{
                    let alert = UIAlertController(title: "Try Again", message: "Wrong username or password.", preferredStyle: .alert)
                    
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    })
                    alert.addAction(ok)
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)})
                }
            }
            
        } catch {
            
//            let alert = UIAlertController(title: "Try again", message: "error", preferredStyle: .alert)
//
//            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
//
//            self.present(alert, animated: true)
//
            let alert = UIAlertController(title: "Try Again", message: "Wrong username or password.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)})
            
            print("Failed")
        }
    }

}

