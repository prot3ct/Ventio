import Foundation

public class ResponseFactory: ResponseFactoryProtocol
{
    public func createResponse() -> ResponseProtocol
    {
        return Response()
    }
}
