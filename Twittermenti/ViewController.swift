//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import SwiftyJSON
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    static let secrets = parseSecrets()
    static let TWITTER_CONSUMER_KEY = secrets.api_key
    static let TWITTER_CONSUMER_SECRET = secrets.api_secret
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    // Instantiation using Twitter's OAuth Consumer Key and secret
    let swifter = Swifter(consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        if let searchText = textField.text {
            swifter.searchTweet(using: searchText, lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    var sentimentScore = 0
                    for prediction in predictions {
                        if prediction.label == "Pos" { sentimentScore += 1 }
                        else if prediction.label == "Neg" { sentimentScore -= 1 }
                    }
                    
                    print(#function + ": sentimentScore is \(sentimentScore)")
                    
                    if sentimentScore > 20 {
                        self.sentimentLabel.text = "😍"
                    } else if sentimentScore > 10 {
                        self.sentimentLabel.text = "😀"
                    } else if sentimentScore > 0 {
                        self.sentimentLabel.text = "🙂"
                    } else if sentimentScore == 0 {
                        self.sentimentLabel.text = "😐"
                    } else if sentimentScore > -10 {
                        self.sentimentLabel.text = "🙁"
                    } else if sentimentScore > -20 {
                        self.sentimentLabel.text = "😡"
                    } else {
                        self.sentimentLabel.text = "🤮"
                    }
                } catch {
                    print(#function + ": There was an error with making a prediction, \(error)")
                }
            } failure: { (error) in
                print(#function + ": The Twitter API request returned the following error: \(error)")
            }
        }
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
