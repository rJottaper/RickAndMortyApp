//
//  ViewController.swift
//  Login
//
//  Created by João Pedro on 18/04/23.
//

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
  func didFinishOnboarding();
};

class OnboardingViewController: UIViewController {
  let pageViewController: UIPageViewController;
  let pageControl = UIPageControl();
  var pages = [UIViewController]();
  var currentVC: UIViewController;
  let buttonNextPage = UIButton();
  
  let screenHeight =  UIScreen.main.bounds.height;
  
  var currentPage = 0 {
    didSet {
      if currentPage == pages.count - 1 {
        buttonNextPage.setTitle("Get Started", for: .normal);
      } else {
        buttonNextPage.setTitle("Next", for: .normal);
      };
    }
  };
  
  weak var delegate: OnboardingViewControllerDelegate?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil);
    
    let pageOne = OnboardingCard(imageOnboardingName: "onboarding1", titleOnboardingText: "Search the Rick and Morty universe and meet new characters, new worlds and another things.");
    let pageTwo = OnboardingCard(imageOnboardingName: "onboarding2", titleOnboardingText: "Each world a new craziness, each world a new different Morty to be surprised and not believed.");
    
    pages.append(pageOne);
    pages.append(pageTwo);
    
    currentVC = pages.first!
      
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configurePageViewController();
    configureButtonNextPage();
  };
};

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
  @objc func getNextViewController(from viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil };
    currentVC = pages[index + 1];
    currentPage = index + 1;
    
    return pages[index + 1];
  };
  
  func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
    guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil };
    currentVC = pages[index - 1];
    currentPage = index - 1;
    
    return pages[index - 1];
  };
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    currentPage = currentPage + 1;
    return getNextViewController(from: viewController);
  };
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    currentPage = currentPage - 1;
    return getPreviousViewController(from: viewController);
  };
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    return pages.count;
  };

  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return pages.firstIndex(of: self.currentVC) ?? 0
  };
};

// MARK: - Styles
extension OnboardingViewController {
  func configurePageViewController() {
    view.backgroundColor = .darkGray;
    
    addChild(pageViewController);
    view.addSubview(pageViewController.view);
    
    let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self]);
    
    pageViewController.view.translatesAutoresizingMaskIntoConstraints = false;
    pageViewController.didMove(toParent: self);
    pageViewController.dataSource = self;
    
    appearance.pageIndicatorTintColor = .lightGray;
    appearance.currentPageIndicatorTintColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1);
    appearance.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 4).isActive = true;
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
      view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
      view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
    ]);
    
    pageViewController.setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil);
    currentVC = pages.first!
  };
  
  func configureButtonNextPage() {
    view.addSubview(buttonNextPage);
    
    buttonNextPage.translatesAutoresizingMaskIntoConstraints = false;
    buttonNextPage.setTitle("Next", for: .normal);
    buttonNextPage.setTitleColor(.darkGray, for: .normal);
    buttonNextPage.addTarget(self, action: #selector(nextPage), for: .touchUpInside);
    buttonNextPage.backgroundColor = UIColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1);
    buttonNextPage.layer.cornerRadius = 10;
    
    NSLayoutConstraint.activate([
      buttonNextPage.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: buttonNextPage.trailingAnchor, multiplier: 4),
      buttonNextPage.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor, constant: screenHeight < 670.0 ? -50 : -100),
      buttonNextPage.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
  
};

// MARK: - Functions
extension OnboardingViewController {
  @objc private func nextPage(sender: UIButton) {
    guard let nextVC = getNextViewController(from: currentVC) else {
      delegate?.didFinishOnboarding();
      
      return;
    };
    pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil);
  };
};

