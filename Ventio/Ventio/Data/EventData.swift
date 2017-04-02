import Foundation
import SwiftyJSON
import RxSwift

public class EventData: EventDataProtocol
{
    private let requester: RequesterProcol
    private let eventFactory: EventFactoryProtocol
    
    init(requester: RequesterProcol, eventFactory: EventFactoryProtocol)
    {
        self.requester = requester
        self.eventFactory = eventFactory
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
    
    public func getEventsForCurrentUser() -> Observable<EventProtocol> { 
        let username = UserDefaults.standard.string(forKey: "username")
        
        return self.requester
            .get(API.eventsForCurrentUserUrl(username: username!))
            .filter { $0.body != nil }
            .flatMap {
                Observable.from(JSON($0.body!)["result"].arrayValue)
            }
            .map { eventJSON in
                let title = eventJSON["title"].stringValue
                let description = eventJSON["description"].string
                let time = eventJSON["time"].string
                let date = eventJSON["date"].string
                let creator = eventJSON["creator"].string
                
                return self.eventFactory.createEvent(title: title, description: description, time: time, date: date, creator: creator)
            }
            .filter { $0 != nil }
            .map { $0! }
    }
    
    public func getEventsForUser(username: String) -> Observable<EventProtocol> {
        return self.requester
            .get(API.eventsForCurrentUserUrl(username: username))
            .filter { $0.body != nil }
            .flatMap {
                Observable.from(JSON($0.body!)["result"].arrayValue)
            }
            .map { eventJSON in
                let title = eventJSON["title"].stringValue
                let description = eventJSON["description"].string
                let time = eventJSON["time"].string
                let date = eventJSON["date"].string
                let creator = eventJSON["creator"].string
                
                return self.eventFactory.createEvent(title: title, description: description, time: time, date: date, creator: creator)
            }
            .filter { $0 != nil }
            .map { $0! }
    }
}
