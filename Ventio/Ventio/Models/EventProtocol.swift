public protocol EventProtocol
{
    var title: String { get set }
    var description: String? { get set }
    var time: String? { get set }
    var date: String? { get set }
    var creator: String? { get set }
}
