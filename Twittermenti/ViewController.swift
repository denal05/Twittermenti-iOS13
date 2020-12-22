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
    
    static let secrets = parseSecrets()
    static let TWITTER_CONSUMER_KEY = secrets.api_key
    static let TWITTER_CONSUMER_SECRET = secrets.api_secret
    
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

// https://stackoverflow.com/questions/24045570/how-do-i-get-a-plist-as-a-dictionary-in-swift
struct Secrets: Decodable {
    private enum CodingKeys: String, CodingKey {
        case api_key, api_secret
    }

    let api_key: String
    let api_secret: String
}

func parseSecrets() -> Secrets {
    let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    return try! decoder.decode(Secrets.self, from: data)
}
