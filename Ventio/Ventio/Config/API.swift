import Foundation

public final class API
{
    private static let ventioApiUrl = "https://ios-db.herokuapp.com"
    
    internal static let signInUrl = "\(ventioApiUrl)/api/auth/login"
    internal static let registerUrl = "\(ventioApiUrl)/api/auth/register"
    internal static let createEventUrl = "\(ventioApiUrl)/api/events"
    
    static func eventsForCurrentUserUrl(username: String) -> String {
        return "\(ventioApiUrl)/api/events/\(username)"
    }
    
    static func addFriendForCurrentUserUrl(username: String) -> String{
        return "\(ventioApiUrl)/api/\(username)/friends"
    }
    
    static func getFriendsForCurrentUserUrl(username: String) -> String {
        return "\(ventioApiUrl)/api/\(username)/friends"
    }
}
