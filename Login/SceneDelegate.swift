//
//  SceneDelegate.swift
//  Login
//
//  Created by João Pedro on 18/04/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  let onboardingViewController = OnboardingViewController();
  let loginViewController = LoginViewController();
  let homeViewController = HomeViewController();

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: UIScreen.main.bounds);
    window?.windowScene = windowScene;
    window?.makeKeyAndVisible();
    
    onboardingViewController.delegate = self;
    loginViewController.delegate = self;
    
    displayOnboarding();
  };
};

extension SceneDelegate {
  private func setRootViewController(viewController: UIViewController, animated: Bool = true) {
    guard animated, let window = self.window else {
      self.window?.rootViewController = viewController;
      self.window?.makeKeyAndVisible();
      
      return;
    };

    let navController = UINavigationController(rootViewController: viewController);
    window.rootViewController = navController;
    window.makeKeyAndVisible();
    UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil);
  };
  
  private func displayOnboarding() {
    setRootViewController(viewController: onboardingViewController);
  };
};

extension SceneDelegate: OnboardingViewControllerDelegate, LoginViewControllerDelegate {
  func didFinishOnboarding() {
    setRootViewController(viewController: loginViewController);
  };
  
  func didLogin() {
    setRootViewController(viewController: homeViewController);
  };
};
