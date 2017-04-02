import UIKit
import RxSwift

class FriendEventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    internal var currentUsername: String!
    
    @IBOutlet weak var friendEventsTitle: UILabel!
    @IBOutlet weak var friendEventsTableView: UITableView!
    
    internal var eventData: EventDataProtocol!
    
    private let disposeBag = DisposeBag()
    
    private var friendEvents = [EventProtocol]()
    {
        didSet
        {
            self.friendEventsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendEventsTableView.delegate = self
        self.friendEventsTableView.dataSource = self
        
        self.startLoading()
        
        self.eventData
            .getEventsForUser(username: self.currentUsername)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: {
                    self.friendEvents.append($0)
            },
                onError: { error in
                    print(error)
            },
                onCompleted: {
                    self.stopLoading()
            })
            .disposed(by: disposeBag)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendEventCell = self.friendEventsTableView
            .dequeueReusableCell(withIdentifier: "FriendEventTableViewCell", for: indexPath)
            as! FriendEventTableViewCell
        
        let currentEvent = self.friendEvents[indexPath.row]
        friendEventCell.friendEventTitle.text = currentEvent.title
        friendEventCell.friendEventDate.text = currentEvent.date
        friendEventCell.FriendEventTime.text = currentEvent.time
        
        return friendEventCell
    }
}

class FriendEventTableViewCell: UITableViewCell
{
    @IBOutlet weak var friendEventTitle: UILabel!
    @IBOutlet weak var FriendEventTime: UILabel!
    @IBOutlet weak var friendEventDate: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
