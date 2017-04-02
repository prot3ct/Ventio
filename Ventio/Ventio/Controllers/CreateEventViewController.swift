import UIKit
import RxSwift

class CreateEventViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var isPublicSwitch: UISwitch!
    
    internal var eventData: EventDataProtocol!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onCreateClicked(_ sender: UIButton) {
        self.startLoading()
        
        let title = self.titleTextField.text
        let description = self.descriptionTextField.text
        let time = self.timeTextField.text
        let date = self.dateTextField.text
        //let isPublic = self.isPublicSwitch.isOn
        
        eventData
            .create(title: title!, description: description!, date: date!, time: time!)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { res in
                self.changeInitialViewController(identifier: "eventsTableViewController")
                self.showSuccess(withStatus: "You have saved your event successfully.")
            }, onError: { error in
                print(error)
                self.showError(withStatus: "Saving event ran into problem. Please try again later.")
            })
            .disposed(by: disposeBag)
    }
    
    private func changeInitialViewController(identifier: String)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard
            .instantiateViewController(withIdentifier: identifier)
        UIApplication.shared.keyWindow?.rootViewController = initialViewController
    }}
