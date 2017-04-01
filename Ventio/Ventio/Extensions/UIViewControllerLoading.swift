import Foundation
import UIKit
import SVProgressHUD

extension UIViewController
{
    func startLoading()
    {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopLoading()
    {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showError(withStatus status: String? = nil)
    {
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showError(withStatus: status)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showSuccess(withStatus status: String? = nil)
    {
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.showSuccess(withStatus: status)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
