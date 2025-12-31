//
//  HomeCoordinatorFactory.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

protocol HomeCoordinatorFactoryProtocol {
  func makeRootController(with router: HomeRoutingLogic, selectedCategory: String?) -> UIViewController
}

final class HomeCoordinatorFactory: HomeCoordinatorFactoryProtocol {
  
  func makeRootController(with router: HomeRoutingLogic, selectedCategory: String?) -> UIViewController {
    let networkManager: NetworkingManagerProtocol = NetworkingManager(networkMonitor: NetworkMonitor())

    let viewModel = HomeViewModel(
      injection: HomeCoordinatorModel.InjectionModel(
        router: router,
        networkManager: networkManager,
        selectedCategory: selectedCategory))
    let viewController = HomeViewController(viewModel: viewModel)
    return viewController
  }
  
}
