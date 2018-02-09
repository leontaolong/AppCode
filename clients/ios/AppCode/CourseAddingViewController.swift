//
//  CourseAddingViewController.swift
//  AppCode
//
//  Created by LEON LOONG on 2/9/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class CourseAddingViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var iptDisplayName: UITextField!
    @IBOutlet weak var iptSLN1: UITextField!
    @IBOutlet weak var iptSLN2: UITextField!
    @IBOutlet weak var iptSLN3: UITextField!
    
    private var courses:[Dictionary<String,String>] = []
    private let db = UserDefaults.standard
    
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        let courseInfo = ["displayName":iptDisplayName.text,
                          "sln1": iptSLN1.text,
                          "sln2": iptSLN2.text,
                          "sln3": iptSLN3.text]
        if (db.array(forKey: "courses") != nil) {
            courses = db.array(forKey: "courses") as! [Dictionary<String, String>]
        }
        courses.append(courseInfo as! [String : String])
        db.set(courses, forKey: "courses")
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register text field delegetes
        iptDisplayName.delegate = self
        iptSLN1.delegate = self
        iptSLN2.delegate = self
        iptSLN3.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        iptDisplayName.resignFirstResponder()
        iptSLN1.resignFirstResponder()
        iptSLN2.resignFirstResponder()
        iptSLN3.resignFirstResponder()
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
