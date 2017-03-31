import Foundation
import RxSwift

public protocol RequesterProcol
{
    func get(_ url: String) -> Observable<ResponseProtocol>
    
    func post(_ url: String, parameters: [String: Any]) -> Observable<ResponseProtocol>
}
