//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    static let TWITTER_CONSUMER_KEY = "TWITTER_CONSUMER_KEY"
    static let TWITTER_CONSUMER_SECRET = "TWITTER_CONSUMER_SECRET"
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple") { (results, metadata) in
            print(#function + ": \(results)")
        } failure: { (error) in
            print(#function + ": The Twitter API request returned the following error: \(error)")
        }

    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

