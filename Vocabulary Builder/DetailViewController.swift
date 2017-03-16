//
//  DetailViewController.swift
//  Vocabulary Builder
//
//  Created by AlexS on 31/07/2016.
//  Copyright © 2016 AStevensProductions. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateAddedLabel: UILabel!
    
    
    var descriptionWord : Word!
    var managedContext : NSManagedObjectContext!
    var dateFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        textView.delegate = self
        setUpUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        print("Save Pressed")
        if (textView.text != ""){
            descriptionWord.wordDescription = textView.text
            do{
                try managedContext.save()
            } catch let error as NSError {
                print("Error saving to context \(error), \(error.userInfo)")
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
}

    @IBAction func back(sender: AnyObject) {
        print("Back Pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setUpUI(){
        let backgroundColour = UIColor(red: 138, green: 43, blue: 226, alpha: 0.85)
        view.backgroundColor = backgroundColour
        
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        let layer = imageView.layer
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
        
        if descriptionWord.photoData != nil {
            
            let imageName = descriptionWord.imageName!
            let image = UIImage(named: imageName)
            imageView.image = image
        }

        wordLabel.text = descriptionWord.word
        textView.text = descriptionWord.wordDescription
        dateAddedLabel.text = "Date Added: \(dateFormatter.stringFromDate(descriptionWord.dateAdded!))"
        
    }
    
    func textViewDidChange(textView: UITextView) { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
        // Save to data store
        descriptionWord.wordDescription = textView.text
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save to context \(error), \(error.userInfo)")
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // TODO-
        // back ground colours need to be set
        // get flicker images displaying check NSURLSession Code 
        // Save to core Data image  
        // Animations
        
        let destVC = segue.destinationViewController
        let flickerVC = destVC.childViewControllers.first! as! FlickerCollectionViewController
        flickerVC.searchWord = self.descriptionWord
        flickerVC.managedContext = self.managedContext
        flickerVC.view.backgroundColor = UIColor(red: 138, green: 43, blue: 226, alpha: 0.85)//138,43,226
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "getPhoto" {
            return true
        }
        return false
    }
    
    //            var photoData = NSData()
    //
    ////            if (imageName.rangeOfString(".png") != nil)
    ////            {
    ////
    ////                photoData = UIImagePNGRepresentation(image!)!
    ////            }
    ////            else  {
    ////                photoData = UIImageJPEGRepresentation(image!, 0.5)!
    ////            }
    ////
    //            imageView.image = UIImage(data: photoData)
}
