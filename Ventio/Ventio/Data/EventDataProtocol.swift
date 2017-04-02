import RxSwift

public protocol EventDataProtocol
{
    func create(title: String, description: String, date: String, time: String) -> Observable<ResponseProtocol>

    func getEventsForCurrentUser() -> Observable<EventProtocol>
    
    func getEventsForUser(username: String) -> Observable<EventProtocol>    
}
