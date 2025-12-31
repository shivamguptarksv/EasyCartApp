//
//  CategoryCoordinatorFactory.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

protocol CategoryCoordinatorFactoryProtocol {
  func makeCategoryController(with router: CategoryViewRouter, categoryList: [String]) -> UIViewController
}

final class CategoryCoordinatorFactory: CategoryCoordinatorFactoryProtocol {
  
  func makeCategoryController(with router: CategoryViewRouter, categoryList: [String]) -> UIViewController {
    let viewModel = CategoriesViewModel(router: router, categories: categoryList)
    let viewController = CategoriesViewController(viewModel: viewModel)
    return viewController
  }
  
}
