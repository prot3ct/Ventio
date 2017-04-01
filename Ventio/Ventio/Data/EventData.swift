import Foundation
import SwiftyJSON
import RxSwift

public class EventData: EventDataProtocol
{
    private let requester: RequesterProcol
    
    init(requester: RequesterProcol)
    {
        self.requester = requester
    }
    
    public func create(title: String, description: String, date: String, time: String, isPublic: Bool) -> Observable<ResponseProtocol> {
        let eventParameters = [
            "title": title,
            "description": description,
            "date": date,
            "time": time,
            //"isPublic": isPublic
        ]
        
        return self.requester.post(API.createEventUrl, parameters: eventParameters)
    }
}
