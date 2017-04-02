//
//  MyFriendsViewController.swift
//  Ventio
//
//  Created by prot3ct on 4/2/17.
//  Copyright © 2017 Georgi Karaboichev. All rights reserved.
//

import UIKit

class MyFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var friendsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                changeInitialViewController(identifier: "eventsTableViewController")
            default:
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    private func changeInitialViewController(identifier: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = self.friendsTableView
            .dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath)
            as! EventTableViewCell
        /*
        let currentEvent = self.events[indexPath.row]
        eventCell.eventTitle.text = currentEvent.title
        eventCell.eventDate.text = currentEvent.date
        eventCell.eventTime.text = currentEvent.time
        */
        return eventCell
    }
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let eventAtIndexPath = self.events[indexPath.row]
        
        let eventDetailsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "eventDetailsViewController")
            as! EventDetailsViewController
        
        eventDetailsViewController.currentEvent = eventAtIndexPath
        self.navigationController?.show(eventDetailsViewController, sender: self)
        
        self.eventsTableView.deselectRow(at: indexPath, animated: true)
        UIApplication.shared.keyWindow?.rootViewController = eventDetailsViewController
    }
    */
}
