//
//  CourseInfoViewController.swift
//  AppCode
//
//  Created by LEON LOONG on 2/1/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class CourseInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var iptDisplayName: UITextField!
    @IBOutlet weak var iptSLN1: UITextField!
    @IBOutlet weak var iptSLN2: UITextField!
    @IBOutlet weak var iptSLN3: UITextField!
    
    private var courses:[Dictionary<String,String>] = []
    private let db = UserDefaults.standard
    public var arrIndex = 0
    
    @IBAction func btnCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        let courseInfo = ["displayName":iptDisplayName.text,
                          "sln1": iptSLN1.text,
                          "sln2": iptSLN2.text,
                          "sln3": iptSLN3.text]

        courses[arrIndex] = courseInfo as! [String : String]
        db.set(courses, forKey: "courses")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure that you want to delete this course from the course list?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel ))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler:{ action in
            self.courses.remove(at: self.arrIndex)
            self.db.set(self.courses, forKey: "courses")
            self.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // register text field delegetes
        iptDisplayName.delegate = self
        iptSLN1.delegate = self
        iptSLN2.delegate = self
        iptSLN3.delegate = self
        
        if (db.array(forKey: "courses") != nil) {
            courses = db.array(forKey: "courses") as! [Dictionary<String, String>]
        }
        renderData()
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
    
    func renderData() {
        var courseSelected = courses[arrIndex]
        iptDisplayName.text = courseSelected["displayName"]
        iptSLN1.text = courseSelected["sln1"]
        iptSLN2.text = courseSelected["sln2"]
        iptSLN3.text = courseSelected["sln3"]
    }
}
