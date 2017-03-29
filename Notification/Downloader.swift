//
//  Downloader.swift
//  Notification
//
//  Created by Anoop Rawat on 29/03/17.
//  Copyright © 2017 Anoop Rawat. All rights reserved.
//

import UIKit

class Downloader {
    
    class func dowloadFile(url:String,completionHandler:@escaping (Bool,URL?) -> Void) {
        
        do {
            var filePath =  try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            filePath.appendPathComponent("image.gif")
            
            if FileManager().fileExists(atPath: filePath.path) {
                completionHandler(true,filePath)
            }
            else {
                
                URLSession.shared.downloadTask(with: URL(string: url)!, completionHandler: { (tempUrl, urlResponse, error) in
                    if error == nil
                    {
                        do {
                             try FileManager.default.moveItem(at: tempUrl!, to: filePath)
                            completionHandler(true,filePath)

                        }
                        catch {
                            print("Cant Move File To Path")
                            completionHandler(false, nil)
                        }
                    }
                }).resume()
            }
        }
        catch {
            print("Invalid Path")
            completionHandler(false, nil)
        }
        
        
    }
    
}
