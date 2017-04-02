import Foundation
import UIKit
import RxSwift
import Cosmos

class EventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var eventsTableView: UITableView!
    internal var eventData: EventDataProtocol!

    private let disposeBag = DisposeBag()
    private var events = [EventProtocol]()
    {
        didSet
        {
            self.eventsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventsTableView.delegate = self
        self.eventsTableView.dataSource = self
        
        self.startLoading()
        
        self.eventData
            .getEventsForCurrentUser()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: {
                self.events.append($0)
            },
            onError: { error in
                print(error)
            },
            onCompleted: {
                self.stopLoading()
            })
            .disposed(by: disposeBag)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                changeInitialViewController(identifier: "logoutViewController")
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    private func changeInitialViewController(identifier: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = self.eventsTableView
            .dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath)
            as! EventTableViewCell
        
        let currentEvent = self.events[indexPath.row]
        eventCell.eventTitle.text = currentEvent.title
        eventCell.eventDate.text = currentEvent.date
        eventCell.eventTime.text = currentEvent.time
        
        return eventCell
     }
    
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
    
}

class EventTableViewCell: UITableViewCell
{
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
