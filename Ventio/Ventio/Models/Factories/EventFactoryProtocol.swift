import Foundation

public protocol EventFactoryProtocol
{
    func createEvent(title: String,
                     description: String?,
                     time: String?,
                     date: String?,
                     creator: String?)
        -> EventProtocol
}
