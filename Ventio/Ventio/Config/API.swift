import Foundation

public final class API
{
    private static let meetupApiUrl = "https://ios-db.herokuapp.com"
    
    internal static let signInUrl = "\(meetupApiUrl)/auth/login"
    internal static let registerUrl = "\(meetupApiUrl)/auth/register"
}
