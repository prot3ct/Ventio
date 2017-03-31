import Foundation
import Alamofire
import RxSwift

public class Requester: RequesterProcol
{
    private let responseFactory: ResponseFactoryProtocol
    
    init(responseFactory: ResponseFactoryProtocol)
    {
        self.responseFactory = responseFactory
    }
    
    public func get(_ url: String) -> Observable<ResponseProtocol>
    {
        return Observable.create
            { observer in
                Alamofire.request(url)
                    .validate()
                    .responseJSON { response in
                        var responseResult = self.buildResponse(alamofireResponse: response)
                        
                        switch response.result
                        {
                        case .success(let value):
                            responseResult.body = value as? [String: Any]
                            observer.onNext(responseResult)
                        case .failure(let error):
                            observer.onError(error)
                        }
                        
                        observer.onCompleted()
                }
                
                return Disposables.create()
        }
    }
    
    public func post(_ url: String, parameters: [String: Any]) -> Observable<ResponseProtocol>
    {
        return Observable.create
            { observer in
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
                    .validate()
                    .responseJSON { response in
                        var responseResult = self.buildResponse(alamofireResponse: response)
                        
                        switch response.result
                        {
                        case .success(let value):
                            responseResult.body = value as? [String: Any]
                            observer.onNext(responseResult)
                        case .failure(let error):
                            observer.onError(error)
                        }
                        
                        observer.onCompleted()
                }
                
                return Disposables.create()
        }
    }
    
    private func buildResponse(alamofireResponse: DataResponse<Any>) -> ResponseProtocol
    {
        let response = alamofireResponse.response
        
        var responseResult = self.responseFactory.createResponse()
        responseResult.statusCode = response?.statusCode
        responseResult.headers = response?.allHeaderFields as? [String: Any]
        
        return responseResult
    }
}
