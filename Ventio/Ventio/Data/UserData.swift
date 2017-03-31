import Foundation
import SwiftyJSON
import RxSwift

public class UserData: UserDataProtocol
{
    private let requester: RequesterProcol
    private let userDefaults: UserDefaults
    
    init(requester: RequesterProcol)
    {
        self.requester = requester
        self.userDefaults = UserDefaults.standard
    }
    
    public func signIn(username: String, password: String) -> Observable<ResponseProtocol>
    {
        let userCredentials = [
            "username": username.lowercased(),
            "passHash": password
        ]
        
        return self.requester
            .post(API.signInUrl, parameters: userCredentials)
            .filter { $0.body != nil }
            .do(onNext: { res in
                let result = JSON(res.body!)["result"]
                let username = result["username"].stringValue
                let userId = result["_id"].stringValue
                
                self.userDefaults.set(userId, forKey: "user_id")
                self.userDefaults.set(username, forKey: "user_username")
            })
    }
    
    public func register(username: String, password: String) -> Observable<ResponseProtocol>
    {
        let userCredentials = [
            "username": username.lowercased(),
            "passHash": password
        ]
        
        return self.requester.post(API.registerUrl, parameters: userCredentials)
    }
    
    public func signOut()
    {
        self.userDefaults.removeObject(forKey: "user_id")
        self.userDefaults.removeObject(forKey: "user_username")
    }
    
    public func isLoggedIn() -> Bool
    {
        let doesUserIdExist = self.userDefaults.contains(key: "user_id")
        let doesUserUsernameExist = self.userDefaults.contains(key: "user_username")
        
        return doesUserIdExist && doesUserUsernameExist
    }
}
