//
//  UserTableViewController.swift
//  MySQLDB
//
//  Created by ifage-user on 09.12.19.
//  Copyright © 2019 ifage-user. All rights reserved.
//

import UIKit



    struct User: Codable {
        var admin: String
        var email: String
        var firstname: String
        var lastname: String
    }

class UserTableViewController: UITableViewController {
    
    private var usersURL = "https://www.rexiagroup.com/webservices/php/selectUsers.php"

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
    }//end of class
    
    func getUsers() {
        // usersURL.append(usersURL(admin: UInt, email: String, firstname: String ,lastname: String))

        let url = URL(string: "https://rexiagroup.com/webservices/php/selectUsers.php")!
        
        let uploadJob = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            
            if error != nil {
                
                // display an alert if there is an error inside the DispatchQueue.main.async
                print ("================")
                print (error!.localizedDescription)
                print ("================")
                
                DispatchQueue.main.async
                    {
                        let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?\n\(error!.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                }
            }
            else
            {
                if let unwrappedData = data {
                    
                    let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                    
                    print (returnedData!)
                    
                    print ("===============")
                    
                        // make sure this JSON is in the format we expect
                        let users = try! JSONDecoder().decode([User].self, from: data!)
                            // try to read out a string array
                    for user in users {
                        print (user.email)
                    }
                    
                    
                    
                    
                    
                    if returnedData?.substring(to: 1) == "1" // insert into database worked
                    {
                        
                        // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                        
                        DispatchQueue.main.async
                            {
                                let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else
                    {
                        // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                        
                        DispatchQueue.main.async
                            {
                                
                                let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        })
        
        uploadJob.resume()
        //}
    }
    }
/*
 
 // Uncomment the following line to preserve selection between presentations
 // self.clearsSelectionOnViewWillAppear = false
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem
 
 dataOfJson(url: self.usersURL)
 }
 
 // MARK: - Table view data source
 
 override func numberOfSections(in tableView: UITableView) -> Int {
 // #warning Incomplete implementation, return the number of sections
 return 0
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // #warning Incomplete implementation, return the number of rows
 return 0
 }
 
 func dataOfJson(url: String) {
 let session = URLSession.shared
 let url = URL(string: url)!
 
 let task = session.dataTask(with: url) { data, response, error in
 
 if error != nil || data == nil {
 print("Client error!")
 return
 }
 
 guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
 print("Server error!")
 return
 }
 
 guard let mime = response.mimeType, mime == "text/html" else {
 print("Wrong MIME type!")
 return
 }
 
 do {
 let json = try JSONSerialization.jsonObject(with: data!, options: [])
 print(json)
 } catch {
 print("JSON error: \(error.localizedDescription)")
 }
 }
 
 task.resume()
 }
 
 /*
 
 struct Response: Codable
 {
 struct User: Codable {
 var email:String
 var firstname:String
 var lastname:String
 }
 
 var users:[User]
 }
 
 let json = try? JSONSerialization.jsonObject(with: data, options: [])
 
 if let recipe = json as? [String: Any] {
 if let yield = recipe["yield"] as? Int {
 recipeObject.yield = yield
 }
 }
 
 struct User: Codable {
 var first_name:String
 var last_name:String
 var country:String
 }
 
 {
 "first_name": "John",
 "last_name": "Doe",
 "country": "United Kingdom"
 }
 
 */
 
 
 
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
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
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
 
 }
 
 
 
 func numberOfSectionsInTableView(tableView: UITableView) -> Int {
 // Return the number of sections.
 return 1
 }
 
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 // Return the number of rows in the section.
 
 return cityValue.count
 }
 
 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
 
 dispatch_async(dispatch_get_main_queue(), { () -> Void in
 //as! MenuTableViewCell
 /**/
 print("stuff")
 
 
 
 
 cell.textLabel?.text = self.cityValue[indexPath.row];//self.menuItems[indexPath.row].city
 //titleLab.text = menuItems[indexPath.row].days
 cell.detailTextLabel?.text = self.inchesValue[indexPath.row]; //"\(self.menuItems[indexPath.row].inches as! Double)"
 
 
 
 
 })
 
 return cell
 
 */

 
 





