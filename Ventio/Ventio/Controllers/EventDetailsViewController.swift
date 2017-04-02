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
    }
    @IBAction func onDeleteClicked(_ sender: Any) {
    }
    
    /*
    @IBAction func onCallButtonClick(_ sender: Any)
    {
        guard self.currentPlaceDetails?.phoneNumber != nil else
        {
            self.showError(withStatus: "Phone number not provided")
            return
        }
        
        let phoneNumber = (self.currentPlaceDetails?.phoneNumber)!
        
        if let dialUrl = URL(string: "telprompt://\(phoneNumber)")
        {
            UIApplication.shared.open(dialUrl, options: [:], completionHandler: nil)
        }
        else
        {
            self.showError(withStatus: "Phone number not provided")
        }
    }
 
    @IBAction func onBrowseButtonClick(_ sender: Any)
    {
        guard self.currentPlaceDetails?.websiteUrl != nil else
        {
            self.showError(withStatus: "Website not provided")
            return
        }
        
        let websiteUrl = (self.currentPlaceDetails?.websiteUrl)!
        
        if let websiteUrl = URL(string: websiteUrl)
        {
            UIApplication.shared.open(websiteUrl, options: [:], completionHandler: nil)
        }
        else
        {
            self.showError(withStatus: "Website not provided")
        }
    }
    */
}
