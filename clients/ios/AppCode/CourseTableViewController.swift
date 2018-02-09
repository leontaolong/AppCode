//
//  CourseTableViewController.swift
//  AppCode
//
//  Created by Leon T Long on 2/8/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class CourseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var CourseTBView: UITableView!
     
    private var courses:[Dictionary<String,String>] = []
    private let db = UserDefaults.standard
    public var arrIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove cell border
        self.CourseTBView.separatorStyle = .none
        
        CourseTBView.delegate = self
        CourseTBView.dataSource = self
        loadCourses()
    }
    
    //Called, when long press occurred
    @objc func handleLongPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.CourseTBView)
            if let indexPath = CourseTBView.indexPathForRow(at: touchPoint) {
                arrIndex = indexPath.row
                self.performSegue(withIdentifier: "CourseInfoSegue", sender: self)
            }
        }
    }
    
    private func loadCourses() {
        if db.array(forKey: "courses") != nil {
            courses = db.array(forKey: "courses") as! [Dictionary<String, String>]
            self.CourseTBView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        loadCourses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "CoursesTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoursesTableViewCell
        
        let course = courses[indexPath.row]
        cell?.CourseDisplayName.text = course["displayName"]
        cell?.selectionStyle = .none
        cell?.isUserInteractionEnabled = true
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        cell?.addGestureRecognizer(gestureRecognizer)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseInfoSegue" {
            let destination = segue.destination as! CourseInfoViewController
            destination.arrIndex = arrIndex
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
