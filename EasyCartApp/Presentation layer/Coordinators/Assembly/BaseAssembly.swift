//
//  Assembly.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

final class BaseCoordinatorAssembly: CoordinatorAssembly {

  func makeHomeCoordinator(with navigation: UINavigationController, with category: String?) -> Coordinator {
    let factory = HomeCoordinatorFactory()
    let coordinator = HomeCoordinator(assembly: self,
                                      navigationController: navigation,
                                      factory: factory,
                                      selectedCategory: category)
    return coordinator
  }
  
  func makeCategoriesCoordinator(with navigation: UINavigationController,
                                 with categoryList: [String]) -> Coordinator {
    let factory = CategoryCoordinatorFactory()
    let coordinator = CategoryCoordinator(assembly: self,
                                          navigationController: navigation,
                                          factory: factory,
                                          categoryList: categoryList)
    return coordinator
  }
  
  func makeCategoryDetailsCoordinator(with navigation: UINavigationController, with category: String?) -> Coordinator {
    let factory = HomeCoordinatorFactory()
    let coordinator = HomeCoordinator(assembly: self,
                                      navigationController: navigation,
                                      factory: factory,
                                      selectedCategory: category)
    return coordinator
  }
  
}
