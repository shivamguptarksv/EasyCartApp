//
//  String+Extentions.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 31/12/25.
//

import Foundation

public extension String {
  
  var capitalizedFirstLetter: String {
    guard let first = self.first else { return self }
    return first.uppercased() + self.dropFirst()
  }
  
}

extension BaseCoordinator {
  
  static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
    return lhs.id == rhs.id
  }
  
}

extension Coordinator {
  
  func start(style: BaseCoordinatorModels.CoordinatorPresentationStyle,
             animated: Bool = true) {
    start(style: style, animated: animated)
  }
  
  func start(coordinator: Coordinator,
             style: BaseCoordinatorModels.CoordinatorPresentationStyle,
             animated: Bool = true) {
    start(coordinator: coordinator, style: style, animated: animated)
  }
  
}
