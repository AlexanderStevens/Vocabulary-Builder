//
//  ViewController.swift
//  Vocabulary Builder
//
//  Created by AlexS on 31/07/2016.
//  Copyright © 2016 AStevensProductions. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // segue named detailSegue
    // cell reuse identifier = Cell
    
    @IBOutlet weak var tableView: UITableView!
    
    var wordsArray = [Word]()
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundColour = UIColor(red: 51, green: 51, blue: 255, alpha: 1)
        self.view.backgroundColor = backgroundColour
        
        checkForData()
        
        let fetchrequest = NSFetchRequest(entityName: "Word")
        do {
            let results = try managedContext.executeFetchRequest(fetchrequest) as! [Word]
            wordsArray = results
            
        } catch let error as NSError {
            print("Could not fetct \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Impliment segue
        performSegueWithIdentifier("detailSegue", sender: indexPath)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let word = wordsArray[indexPath.row]
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = word.word
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndexPath = sender as! NSIndexPath
        let index = selectedIndexPath.row
        let dest = segue.destinationViewController as! DetailViewController
        dest.descriptionWord = wordsArray[index]
        dest.managedContext = managedContext
    }
    
    @IBAction func addWord(sender: AnyObject) {
        // Need to add textField
        // Add word
        let alert = UIAlertController(title: "Add a Word", message: "Add a word to the disctionary", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {(action:UIAlertAction) -> Void in
            
            let textField = alert.textFields!.first
            self.saveWord(textField!.text!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (action:UIAlertAction) in
        })
        
        alert.addTextFieldWithConfigurationHandler{ (textField:UITextField) -> Void in
            }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.view.setNeedsLayout()
        presentViewController(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    func saveWord(word:String) {
        let entity = NSEntityDescription.entityForName("Word", inManagedObjectContext: managedContext)
        let thisWord = Word(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        thisWord.word = word
        thisWord.dateAdded = NSDate()
        
        do {
            try managedContext.save()
            wordsArray.append(thisWord)
            
        } catch let error as NSError {
            print("Could not save to context \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    func checkForData() {
//        let request = NSFetchRequest(entityName: "Word")
//        request.predicate = NSPredicate(format:  "word != nil")
//        
//        let count = try managedContext.countForFetchRequest(request) {
//        
//        if count > 0 {return}
//        
//        let entity = NSEntityDescription.entityForName("Word", inManagedObjectContext: managedContext)
//        let thisWord = Word(entity: entity!, insertIntoManagedObjectContext: managedContext)
//        
//        let image = UIImage(named: "first.jpeg")
//        let photoData = UIImagePNGRepresentation(image!)
//        
//        thisWord.word = "First"
//        thisWord.wordDescription = "Coming before all others in time or order; earliest; 1st."
//        thisWord.dateAdded = NSDate()
//        thisWord.photoData = photoData
//        thisWord.imageName = "first.jpeg"
//        }
//        catch let error :NSError{
//            print(error)
//        }
    }
    
}

