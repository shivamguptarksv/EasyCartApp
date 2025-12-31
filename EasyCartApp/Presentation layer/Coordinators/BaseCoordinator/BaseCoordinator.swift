//
//  BaseCoordinator.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.

import UIKit

class BaseCoordinator<Factory>: NSObject, Coordinator {
  
  let id = UUID()

  private(set) unowned var navigationController: UINavigationController

  let assembly: CoordinatorAssembly
  
  let factory: Factory
      
  weak var parentCoordinator: Coordinator?

  private(set) var childCoordinators: [UUID: WeakCoordinator] = [:]
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController, factory: Factory) {
    self.assembly = assembly
    self.navigationController = navigationController
    self.factory = factory
  }
  
  func createRootViewController() -> UIViewController {
    return UIViewController()
  }
  
  func start(style: BaseCoordinatorModels.CoordinatorPresentationStyle, animated: Bool) {
    let viewController = createRootViewController()
    switch style {
    case .setRoot:
      navigationController.setViewControllers([viewController], animated: animated)
    case .push:
      navigationController.pushViewController(viewController, animated: animated)
    }
  }
  
  func start(coordinator: Coordinator, style: BaseCoordinatorModels.CoordinatorPresentationStyle, animated: Bool) {
    childCoordinators[coordinator.id] = WeakCoordinator(coordinator: coordinator)
    coordinator.parentCoordinator = self
    coordinator.start(style: style, animated: animated)
  }
  
  func stop() {
    childCoordinators.values.forEach { $0.coordinator?.stop() }
    childCoordinators.removeAll()
    parentCoordinator?.removeChild(by: id)
    parentCoordinator = nil
  }
  
  func removeChild(by id: UUID) {
    childCoordinators.removeValue(forKey: id)
  }
  
  deinit {
    stop()
  }
  
}
