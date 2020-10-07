//
//  ViewController.swift
//  MobileFormFill
//
//  Created by Manali Rami on 2020-10-06.
//  Copyright © 2020 Manali Rami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data:DataForm!
    
    var dataList = [DataForm]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var maleButton: UIButton!
    
    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var javabutton: UIButton!
    @IBOutlet weak var kotlinButton: UIButton!
    @IBOutlet weak var swiftButton: UIButton!
    @IBOutlet weak var flutterButton: UIButton!
    @IBOutlet weak var reactButton: UIButton!
    private var genderSelected = String()
    private var skillSet = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func SkillsButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let tag = sender.tag
        
        switch tag {
            
        case 4: updateSkills(skill: "Java")
        case 5: updateSkills(skill: "Kotlin")
        case 6: updateSkills(skill: "Swift")
        case 7: updateSkills(skill: "Flutter")
        case 8: updateSkills(skill: "React")
        default: print("Nothing selected")
            
        }
        
    }
    
    func updateSkills(skill : String) {
        if skillSet.isEmpty || !skillSet.contains(skill) {
            skillSet.append(skill)
        } else  {
            skillSet = skillSet.filter { $0 != skill }
        }
    }
    
    @IBAction func SaveData(_ sender: UIButton) {
        
        
        let name = fullNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        // validate input fields
        
        if name == "" || email == "" || password == "" || (maleButton.isSelected == false && femaleButton.isSelected == false && otherButton.isSelected == false) || (javabutton.isSelected == true && swiftButton.isSelected == true  && kotlinButton.isSelected == true && reactButton.isSelected == true && flutterButton.isSelected == true && reactButton.isSelected == true) {
            let alertController = UIAlertController(title: "Oops", message: "Please note that all fields are required.", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        data = DataForm(entity: DataForm.entity(), insertInto: context)
        data.fullName = name
        data.gender = genderSelected
        data.skills = skillSet.map { String($0) }.joined(separator: ", ")
        
        // validate Email
        
        if email!.isValidEmail {
            data.email = email
        } else {
            let alertController = UIAlertController(title: "Oops", message: "email not valid", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        //validate Password
        
        if password!.isValidPassword {
            print("valid password")
        } else {
            let alertController = UIAlertController(title: "Oops", message: "Password must contain one uppercase, one lowercase, one special character and must be between 8 to 16 ", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        appDelegate.saveContext()
    }
    
    
    @IBAction func RadioButtonAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            maleButton.isSelected = true
            femaleButton.isSelected = false
            otherButton.isSelected = false
            genderSelected = "Male"
            
        } else if sender.tag == 2 {
            
            maleButton.isSelected = false
            femaleButton.isSelected = true
            otherButton.isSelected = false
            genderSelected = "Female"
            
        } else if sender.tag == 3 {
            
            maleButton.isSelected = false
            femaleButton.isSelected = false
            otherButton.isSelected = true
            genderSelected = "Other"
            
        }
    }
}


// Extension to Validate email and password
extension String {
    var isValidEmail: Bool {
        let emailText = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3}")
        return emailText.evaluate(with: self)
    }
    var isValidPassword: Bool {
        let passwrdRegEx = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,16}")
        return passwrdRegEx.evaluate(with: self)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case fullNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            maleButton.becomeFirstResponder()
        case maleButton:
            femaleButton.becomeFirstResponder()
        case femaleButton:
            otherButton.becomeFirstResponder()
        default:
            otherButton.resignFirstResponder()
        }
        return true
    }
}



