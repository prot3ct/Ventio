import UIKit
import RxSwift

class AccountViewController: UIViewController
{    
    internal var userData: UserDataProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        print("IT DAMN WORKS")
    }
    
    

}
