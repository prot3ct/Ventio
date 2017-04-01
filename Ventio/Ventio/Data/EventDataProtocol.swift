import RxSwift

public protocol EventDataProtocol
{
    func create(title: String, description: String, date: String, time: String, isPublic: Bool) -> Observable<ResponseProtocol>
}
