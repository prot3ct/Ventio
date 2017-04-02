import Foundation
import UIKit
import RxSwift
import Cosmos

class EventsTableViewController: UITableViewController {
    @IBOutlet var eventsTableView: UITableView!
    internal var userData: UserDataProtocol!
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
                print("HRESADG")
                self.events.append($0)
            },
            onError: { error in
                print(error)
            },
            onCompleted: {
                print("Completed")
                self.stopLoading()
            })
            .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    @IBAction func onLogoutClicked(_ sender: UIButton) {
        self.startLoading()
        self.userData.signOut()
        self.changeInitialViewController(identifier: "accountViewController")
        self.showSuccess(withStatus: "You have signed out successfully")
    }
    
    private func changeInitialViewController(identifier: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = self.eventsTableView
            .dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath)
            as! EventTableViewCell
        
        let currentEvent = self.events[indexPath.row]
        eventCell.eventTitle.text = currentEvent.title
        eventCell.eventDate.text = currentEvent.date
        eventCell.eventTime.text = currentEvent.time
        
        return eventCell
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let eventAtIndexPath = self.events[indexPath.row]
        
        let eventDetailsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "eventDetailsViewController")
            as! EventDetailsViewController
        
        eventDetailsViewController.currentEvent = eventAtIndexPath
        self.navigationController?.show(eventDetailsViewController, sender: self)
        
        self.eventsTableView.deselectRow(at: indexPath, animated: true)
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
