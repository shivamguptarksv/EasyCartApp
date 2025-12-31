//
//  SceneDelegate.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var coordinator: Coordinator?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    window.makeKeyAndVisible()
    let navigation = UINavigationController()
    window.rootViewController = navigation
    self.window = window
    
    let assembly = BaseCoordinatorAssembly()
    self.coordinator = assembly.makeHomeCoordinator(with: navigation, with: nil)
    self.coordinator?.start(style: .setRoot, animated: false)
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  
  func sceneDidBecomeActive(_ scene: UIScene) {}
  
  func sceneWillResignActive(_ scene: UIScene) {}
  
  func sceneWillEnterForeground(_ scene: UIScene) {}
  
  func sceneDidEnterBackground(_ scene: UIScene) {}
  
}
