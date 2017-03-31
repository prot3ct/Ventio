public protocol ResponseProtocol
{
    var body: [String: Any]? { get set }
    var message: String? { get set }
    var statusCode: Int? { get set }
    var headers: [String: Any]? { get set }
}
