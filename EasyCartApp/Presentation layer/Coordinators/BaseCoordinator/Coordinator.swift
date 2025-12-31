//
//  Coordinator.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

protocol Coordinator: AnyObject {
  
  var id: UUID { get }
  var navigationController: UINavigationController { get }
  func start(style: BaseCoordinatorModels.CoordinatorPresentationStyle, animated: Bool)
  func start(coordinator: Coordinator, style: BaseCoordinatorModels.CoordinatorPresentationStyle, animated: Bool)
  func removeChild(by id: UUID)
  func stop()
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [UUID: WeakCoordinator] { get }
  
}
