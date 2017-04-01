import Foundation
import SwiftyJSON
import RxSwift

public class EventData: EventDataProtocol
{
    private let requester: RequesterProcol
    private let userDefaults: UserDefaults;
    
    init(requester: RequesterProcol)
    {
        self.requester = requester
        self.userDefaults = UserDefaults.standard
    }
    
    public func create(title: String, description: String, date: String, time: String) ->
        Observable<ResponseProtocol> {
            
        let username = UserDefaults.standard.string(forKey: "username")!
            
        let eventParameters = [
            "title": title,
            "description": description,
            "date": date,
            "time": time,
            "creator": username
        ]
        
        return self.requester.post(API.createEventUrl, parameters: eventParameters)
    }
}
