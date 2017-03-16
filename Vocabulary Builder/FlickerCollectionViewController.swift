//
//  FlickerCollectionViewController.swift
//  Vocabulary Builder
//
//  Created by AlexS on 02/08/2016.
//  Copyright © 2016 AStevensProductions. All rights reserved.
//

import UIKit
import CoreData

class FlickerCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let apiKey = "970871c00fe0eea37f1755261b36c0d6"
    
    var searchWord : Word!
    var managedContext: NSManagedObjectContext!
    
    var selectedPhotoIndexPath : NSIndexPath? {
        didSet {
            /// highlight selected cell
            
        }
    }
    
    override func viewDidLoad() {
        title = searchWord.word
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            cell.highlighted = true
        }
    }
    
    @IBAction func useSelectedImage(sender: AnyObject) {
        if selectedPhotoIndexPath != nil {
            
            //image @ selectedPhotoIndex
            // get photo data and save to store 
            
           // searchWord.imageName
           // searchWord.photoData =
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save to context \(error), \(error.userInfo)")
            }
        }
        else {
            // create prompt for user to select photot
        }
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
