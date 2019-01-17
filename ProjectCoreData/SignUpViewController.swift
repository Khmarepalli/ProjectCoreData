//
//  SignUpViewController.swift
//  ProjectCoreData
//
//  Created by Krishna Marepalli on 1/15/19.
//  Copyright © 2019 Krishna Marepalli. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpBtn(_ sender: Any) {
        if usernameTextField.text != nil || passwordTextField.text != nil{
            createData()
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
    
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(usernameTextField.text, forKeyPath: "username")
            user.setValue(passwordTextField.text, forKey: "password")
        
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
            
        } catch let error as NSError {
            let alert = UIAlertController(title: "Try Again", message: "Wrong username or password.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)})
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
