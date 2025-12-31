//
//  WeakCoordinator.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import Foundation

class WeakCoordinator {
  
  weak var coordinator: Coordinator?
  
  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }
  
}
