import Foundation
import UIKit

protocol OnlineApplicationAssembler{
    func resolve(navigationController: UINavigationController) -> OnlineApplicationView
    func resolve(navigationController: UINavigationController) -> OnlineApplicationViewModel
    func resolve() -> OnlineApplicationUseCaseType
    func resolve(navigationController: UINavigationController) -> OnlineApplicationNavigatorType
}

extension OnlineApplicationAssembler{
    func resolve(navigationController: UINavigationController) -> OnlineApplicationView{
        return OnlineApplicationView(viewModel: resolve(navigationController: navigationController))
    }

    func resolve(navigationController: UINavigationController) -> OnlineApplicationViewModel{
        return OnlineApplicationViewModel(useCase: resolve(), navigator: resolve(navigationController: navigationController))
    }

}

extension OnlineApplicationAssembler where Self: DefaultAssembler{
    func resolve() -> OnlineApplicationUseCaseType{
        return OnlineApplicationUseCase(gateway: MarketGateway(), onlineApplicationGateway: OnlineApplicationGateway(), cardConfigGateway: CardConfigGateway(), cityGateway: CityGateway())
    }

    func resolve(navigationController: UINavigationController) -> OnlineApplicationNavigatorType{
        return OnlineApplicationNavigator(navigationController: navigationController)
    }
}

extension OnlineApplicationAssembler where Self: PreviewAssembler{
    func resolve() -> OnlineApplicationUseCaseType {
        return OnlineApplicationUseCase(gateway: MarketGateway(), onlineApplicationGateway: OnlineApplicationGateway(), cardConfigGateway: CardConfigGateway(), cityGateway: CityGateway())
    }
    func resolve(navigationController: UINavigationController) -> OnlineApplicationNavigatorType{
        return OnlineApplicationNavigator(navigationController: navigationController)
    }
}
