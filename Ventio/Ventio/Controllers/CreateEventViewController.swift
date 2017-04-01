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
        
        let title = self.timeTextField.text
        let description = self.descriptionTextField.text
        let time = self.timeTextField.text
        let date = self.dateTextField.text
        //let isPublic = self.isPublicSwitch.isOn
        
        eventData
            .create(title: title!, description: description!, date: date!, time: time!)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { res in
                //self.changeInitialViewController(identifier: "homeAuthVC")
                self.showSuccess(withStatus: "You have saved your event successfully.")
            }, onError: { error in
                print(error)
                self.showError(withStatus: "Saving event ran into problem. Please try again later.")
            })
            .disposed(by: disposeBag)
    }
}
