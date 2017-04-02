import Foundation

public class EventFactory: EventFactoryProtocol
{
    public func createEvent(title: String,
                            description: String?,
                            time: String?,
                            date: String?,
                            creator: String?)
        -> EventProtocol
    {
        return Event(title: title,
                     description: description,
                     time: time,
                     date: date,
                     creator: creator)
    }
}
