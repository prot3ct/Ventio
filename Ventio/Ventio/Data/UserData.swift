import Foundation
import SwiftyJSON
import RxSwift

public class UserData: UserDataProtocol
{
    private let requester: RequesterProcol
    
    init(requester: RequesterProcol)
    {
        self.requester = requester
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
                let username = res.body!["username"]!

                UserDefaults.standard.set(username, forKey: "username")
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
        UserDefaults.standard.removeObject(forKey: "username")
    }
    
    public func isLoggedIn() -> Bool
    {
        let doesUserUsernameExist = UserDefaults.standard.contains(key: "username")
        
        return doesUserUsernameExist
    }

    public func addFriend(username: String) -> Observable<ResponseProtocol> {
        let currentUser: String = UserDefaults.standard.string(forKey: "username")!
        
        let friend =  [
            "username": username.lowercased()
        ]
        
        return self.requester.post(API.addFriendForCurrentUserUrl(username: currentUser), parameters: friend)
    }
    
    public func getFriendsForCurrentUser() -> Observable<String> {
        let currentUsername: String = UserDefaults.standard.string(forKey: "username")!
        
        var counter: Int = 0;
        return self.requester
            .get(API.getFriendsForCurrentUserUrl(username: currentUsername))
            .filter { $0.body != nil }
            .flatMap {
                Observable.from(JSON($0.body!)["result"].arrayValue)
            }
            .map { friendJSON in
                let friendUsername = friendJSON["friends"][counter].string
                
                counter += 1
                return friendUsername
            }
            .filter { $0 != nil }
            .map { $0! }
    }
}
