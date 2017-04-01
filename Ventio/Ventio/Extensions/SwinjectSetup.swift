import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard
{
    class func setup()
    {
        Container.loggingFunction = nil
        
        setupViewConrollers(defaultContainer)
        setupHelpers(defaultContainer)
        setupData(defaultContainer)
        setupFactories(defaultContainer)
    }
}

private func setupViewConrollers(_ defaultContainer: Container)
{
    defaultContainer.storyboardInitCompleted(AccountViewController.self)
    { (r, c) in
        c.userData = r.resolve(UserDataProtocol.self)
    }

}

private func setupHelpers(_ defaultContainer: Container)
{
    defaultContainer.register(RequesterProcol.self)
    { r in
        Requester(responseFactory: r.resolve(ResponseFactoryProtocol.self)!)
    }
}

private func setupData(_ defaultContainer: Container)
{

    defaultContainer.register(UserDataProtocol.self)
    { r in
        UserData(requester: r.resolve(RequesterProcol.self)!)
    }
}

private func setupFactories(_ defaultContainer: Container)
{
    defaultContainer.register(ResponseFactoryProtocol.self) { _ in ResponseFactory() }
}
