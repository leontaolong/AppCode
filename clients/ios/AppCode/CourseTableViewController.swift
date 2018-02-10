//
//  CourseTableViewController.swift
//  AppCode
//
//  Created by Leon T Long on 2/8/18.
//  Copyright © 2018 leontaolong. All rights reserved.
//

import UIKit

class CourseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  URLSessionDelegate {
    
    @IBOutlet weak var CourseTBView: UITableView!
     
    private var courses:[Dictionary<String,String>] = []
    private let db = UserDefaults.standard
    public var arrIndex = 0
//    private let reguestURL = "http://appcode.leontaolong.com/v1/register"
    private let reguestURL = "http://localhost:8080/v1/register"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust CourseTBView UI and register delegates
        CourseTBView.separatorStyle = .none
        CourseTBView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
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
        registerCourse(courses[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CourseInfoSegue" {
            let destination = segue.destination as! CourseInfoViewController
            destination.arrIndex = arrIndex
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Pass test server with self signed certificate
        if challenge.protectionSpace.host == "https://localhost" {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }

    func registerCourse(_ courseInfo :Dictionary<String,String>) {
        var request = URLRequest(url: URL(string: reguestURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accountInfo = db.dictionary(forKey: "accountInfo") {
            var data = courseInfo
            data["username"] = (accountInfo["email"] as? String)
            data["password"] = (accountInfo["password"] as? String)
            

            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
//            let jsonString = String(data: jsonData!, encoding: .utf8)
            
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            
            request.httpBody = jsonData
            

            let task = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // check for fundamental networking error
                    OperationQueue.main.addOperation {
                        let alert = UIAlertController.init(title: "Error!", message: "Network Error", preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "Retry", style: .default, handler: {(alert: UIAlertAction!) in
                            self.viewDidLoad()})
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                let responseString = String(data: data, encoding: String.Encoding.utf8)
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // check for http errors
                    OperationQueue.main.addOperation {
                        let alert = UIAlertController.init(title: "Error!", message: responseString, preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "Retry", style: .default, handler: {(alert: UIAlertAction!) in
                            self.viewDidLoad()})
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
                let alert = UIAlertController.init(title: "Registration Result", message: responseString, preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                    self.viewDidLoad()})
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)

            }
            task.resume()
        } else {
            let alert = UIAlertController(title: "Error", message: "Missing Acount Info, go to Account Info page to complete them.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
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
