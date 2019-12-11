//
//  ViewController.swift
//  MySQLDB
//
//  Created by ifage-user on 02.12.19.
//  Copyright © 2019 ifage-user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The textfield outlets
    @IBOutlet weak var Email: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    
    // the button action fonction
    @IBAction func uploadData(_ sender: Any) {
        let url = URL(string: "https://rexiagroup.com/webservices/php/createUser2.php")
        // locahost MAMP - change to point to your database server
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var dataString = "password=765432"
        // starting POST string with a secretWord
        
        // the POST string has entries separated by &
        
        dataString = dataString + "&email=\(Email.text!)" // add items as name and value
        dataString = dataString + "&firstname=\(firstName.text!)"
        dataString = dataString + "&lastname=\(lastName.text!)"
        
        // convert the post string to utf8 format
        
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        //do
        //{
            
            // the upload task, uploadJob, is defined here
            
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
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
            }
            uploadJob.resume()
        //}
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
 
 https://www.dropbox.com/s/cx6s06zvqlp7r3x/SwiftTableView.rtf?dl=0
 https://stackoverflow.com/questions/28646290/swift-php-how-to-display-mysql-data-json-in-uitableview-using-alamofire
 https://stackoverflow.com/questions/36649650/passing-label-data-from-a-tableview-to-another-view-controller?rq=1
 https://stackoverflow.com/questions/28260055/connect-to-an-online-database-mysql-from-swift-using-php-xcode/28267532
 
 */
