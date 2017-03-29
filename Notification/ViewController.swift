//
//  ViewController.swift
//  Notification
//
//  Created by Anoop Rawat on 29/03/17.
//  Copyright © 2017 Anoop Rawat. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound]) { (isGranted, error) in
            if isGranted {
                let content = UNMutableNotificationContent()
                content.title = "Hey!"
                content.body = "Your Pizza Arrived"
                Downloader.dowloadFile(url: "https://d3ui957tjb5bqd.cloudfront.net/uploads/2015/03/michaelreynaud-compressor.gif") { (isSaved, filePath) in
                    if isSaved {
                        do {
                            let attachement = try UNNotificationAttachment(identifier: "image.gif", url: filePath!, options: nil)
                            content.attachments = [attachement]
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval:1, repeats: false)
                            let request = UNNotificationRequest(identifier: "local_notification", content: content, trigger: trigger)
                            center.add(request) { (error) in
                                if error != nil {
                                    print("Unable To Add Notification " + (error?.localizedDescription)!)
                                }
                            }
                        }
                        catch {
                            print("Error In Attachment" + error.localizedDescription)
                        }
                        
                    }
                    
                }

            }
            
        }
        
        
     
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

