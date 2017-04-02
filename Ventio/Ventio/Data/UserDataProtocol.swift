import RxSwift

public protocol UserDataProtocol
{
    func signIn(username: String, password: String) -> Observable<ResponseProtocol>
    
    func register(username: String, password: String) -> Observable<ResponseProtocol>
    
    func signOut()
    
    func isLoggedIn() -> Bool
    
    func addFriend(username: String) -> Observable<ResponseProtocol>
    
    func getFriendsForCurrentUser() -> Observable<String>
}
