//
//  SecondViewController.swift
//  AppCode
//
//  Created by LEON LOONG on 2/1/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    
    private var accountInfo:[String:String] = [:]
    private let db = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register textfield delegates
        emailText.delegate = self;
        pwdText.delegate = self;
        
        // get accountInfo from local db
        if let dbAccountInfo = db.dictionary(forKey: "accountInfo") {
            accountInfo = dbAccountInfo as! [String : String]
            emailText.text = accountInfo["email"]
            pwdText.text = accountInfo["password"]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        // set accountInfo into local db
        accountInfo["email"] = emailText.text
        accountInfo["password"] = pwdText.text
        db.set(accountInfo, forKey: "accountInfo")
        
        let alert = UIAlertController(title: "Success", message: "Account Info Updated Successfully!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailText.resignFirstResponder()
        pwdText.resignFirstResponder()
    }

}

