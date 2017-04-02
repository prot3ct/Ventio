import UIKit
import RxSwift
import Cosmos

class EventDetailsViewController: UIViewController
{
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventCreator: UILabel!
    
    internal var currentEvent: EventProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.eventTitle.text = currentEvent.title
        self.eventDescription.text = currentEvent.description
        self.eventDate.text = currentEvent.date
        self.eventTime.text = currentEvent.time
        self.eventCreator.text = currentEvent.creator
        
        self.eventDescription.layer.borderWidth = CGFloat(1.0)
        self.eventDescription.layer.cornerRadius = CGFloat(5.0)
    }
    @IBAction func onDeleteClicked(_ sender: Any) {
        // TO DO
    }
}
