//
//  OnboardingCard.swift
//  Login
//
//  Created by João Pedro on 20/04/23.
//

import UIKit

class OnboardingCard: UIViewController {
  let stackView = UIStackView();
  let imageOnboarding = UIImageView();
  let titleOnboarding = UILabel();
  
  let imageOnboardingName: String;
  let titleOnboardingText: String;
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    configureImageOnboarding();
    configureTitleOnboarding();
  };
  
  init(imageOnboardingName: String, titleOnboardingText: String) {
    self.imageOnboardingName = imageOnboardingName;
    self.titleOnboardingText = titleOnboardingText;
    
    super.init(nibName: nil, bundle: nil);
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  };
};

extension OnboardingCard {
  func configureImageOnboarding() {
    view.addSubview(imageOnboarding)
    
    imageOnboarding.translatesAutoresizingMaskIntoConstraints = false;
    imageOnboarding.contentMode = .scaleAspectFit;
    imageOnboarding.image = UIImage(named: imageOnboardingName);
    
    NSLayoutConstraint.activate([
      imageOnboarding.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageOnboarding.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: imageOnboarding.trailingAnchor, multiplier: 1),
      imageOnboarding.heightAnchor.constraint(equalToConstant: 200)
    ]);
  };
  
  func configureTitleOnboarding() {
    view.addSubview(titleOnboarding);
    
    titleOnboarding.translatesAutoresizingMaskIntoConstraints = false;
    titleOnboarding.textAlignment = .center
    titleOnboarding.font = .preferredFont(forTextStyle: .title2);
    titleOnboarding.adjustsFontForContentSizeCategory = true;
    titleOnboarding.numberOfLines = 0;
    titleOnboarding.text = titleOnboardingText;
    titleOnboarding.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1)
    
    NSLayoutConstraint.activate([
      titleOnboarding.topAnchor.constraint(equalToSystemSpacingBelow: imageOnboarding.bottomAnchor, multiplier: 4),
      titleOnboarding.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleOnboarding.trailingAnchor, multiplier: 2),
    ]);
  };
};
