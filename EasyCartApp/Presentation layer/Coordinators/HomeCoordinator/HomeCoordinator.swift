//
//  HomeCoordinator.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

final class HomeCoordinator: BaseCoordinator<HomeCoordinatorFactoryProtocol> {
  
  private let selectedCategory: String?
  
  init(assembly: CoordinatorAssembly,
       navigationController: UINavigationController,
       factory: HomeCoordinatorFactoryProtocol,
       selectedCategory: String? = nil) {
    self.selectedCategory = selectedCategory
    super.init(assembly: assembly,
               navigationController: navigationController,
               factory: factory)
  }
  
  override func createRootViewController() -> UIViewController {
    return factory.makeRootController(with: self, selectedCategory: selectedCategory)
  }
  
}

// MARK: HomeRoutingLogic

extension HomeCoordinator: HomeRoutingLogic {

  func routeToCategoryList(with categories: [String]) {
    let coordinator = assembly.makeCategoriesCoordinator(with: navigationController, with: categories)
    start(coordinator: coordinator, style: .push)
  }
  
  func routeToItemDetail(with itemData: DataModel) {
    let itemDetailViewContoller = ItemDetailViewContoller(item: itemData)
    navigationController.pushViewController(itemDetailViewContoller, animated: false)
  }
  
}
