import UIKit
import RxSwift

class MyFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var friendUsernameTextField: UITextField!
    @IBOutlet weak var friendsTableView: UITableView!
    internal var UserData: UserDataProtocol!
    
    private let disposeBag = DisposeBag()
    private var friends = [String]()
    {
        didSet
        {
            self.friendsTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func onAddFriendClicked(_ sender: UIButton) {
        self.startLoading()
        
        let friendUsername = self.friendUsernameTextField.text;
        
        self.UserData.addFriend(username: friendUsername!)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { res in
                self.showSuccess(withStatus: "Friend added successfully.")
            }, onError: { error in
                print(error);
                self.showError(withStatus: "User not found or you have already added this user.")
            })
            .disposed(by: disposeBag)
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
        return self.friends.count
    }
    
    private func changeInitialViewController(identifier: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendCell = self.friendsTableView
            .dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath)
            as! FriendTableViewCell
        
         let currentFriend = self.friends[indexPath.row]
         friendCell.friendUsername.text = currentFriend
        
        return friendCell
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

class FriendTableViewCell: UITableViewCell
{
    @IBOutlet weak var friendUsername: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
