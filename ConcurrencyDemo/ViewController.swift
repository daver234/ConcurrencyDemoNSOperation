//
//  ViewController.swift
//  ConcurrencyDemo
//
//  Created by Hossam Ghareeb on 11/15/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//
//
//  Modified Dave Rothschild May 29, 2016

import UIKit

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg", "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg", "http://algoos.com/wp-content/uploads/2015/08/ireland-02.jpg", "http://bdo.se/wp-content/uploads/2014/01/Stockholm1.jpg"]

class Downloader {
    
    class func downloadImageWithURL(url:String) -> UIImage! {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        return UIImage(data: data!)
    }
}

class ViewController: UIViewController {
    
    var queue = NSOperationQueue()

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Using addOperationWithBlock to create a new operation with the given block (closure in Swift)
    //
    // Then use NSOperationQueue to get the image to the main queue
    @IBAction func didClickOnStart(sender: AnyObject) {
        
        queue = NSOperationQueue()
        
        queue.addOperationWithBlock { () -> Void in
            
            let img1 = Downloader.downloadImageWithURL(imageURLs[0])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.imageView1.image = img1
            })
        }
        
        queue.addOperationWithBlock { () -> Void in
            let img2 = Downloader.downloadImageWithURL(imageURLs[1])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.imageView2.image = img2
            })
            
        }
        
        queue.addOperationWithBlock { () -> Void in
            let img3 = Downloader.downloadImageWithURL(imageURLs[2])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.imageView3.image = img3
            })
            
        }
        
        queue.addOperationWithBlock { () -> Void in
            let img4 = Downloader.downloadImageWithURL(imageURLs[3])
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.imageView4.image = img4
            })
            
        }
        
    }
    
    // use slider so you can test how responsive the UI is while the tasks above are executing
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        self.sliderValueLabel.text = "\(sender.value * 100.0)"
    }

}

