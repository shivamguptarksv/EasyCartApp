//
//  CategoryCoordinator.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

final class CategoryCoordinator: BaseCoordinator<CategoryCoordinatorFactoryProtocol> {
  
  private let categoryList: [String]
  
  init(assembly: CoordinatorAssembly,
       navigationController: UINavigationController,
       factory: CategoryCoordinatorFactoryProtocol,
       categoryList: [String]) {
    self.categoryList = categoryList
    super.init(assembly: assembly, navigationController: navigationController, factory: factory)
  }
  
  override func createRootViewController() -> UIViewController {
    return factory.makeCategoryController(with: self, categoryList: categoryList)
  }
  
}

// MARK: HomeRoutingLogic

extension CategoryCoordinator: CategoryViewRouter {
  
  func routeToCategoryDetail(for category: String) {
    let coordinator = assembly.makeCategoryDetailsCoordinator(with: navigationController, with: category)
    start(coordinator: coordinator, style: .push)
  }
  
}
