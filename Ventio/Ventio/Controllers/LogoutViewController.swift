import UIKit

class LogoutViewController: UIViewController {
    internal var userData: UserDataProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onLogoutClicked()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onLogoutClicked() {
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
}
