//
//  Header.swift
//  Login
//
//  Created by João Pedro on 11/05/23.
//

import UIKit

class Header: UIView {
  let headerTitle = UILabel();
  let headerSubtitle = UILabel();
  
  var headerTitleText: String = ""
  var headerSubtitleText: String = ""
  
  required init(headerTitleText: String, headerSubtitleText: String) {
    super.init(frame: CGRect.zero);
    
    self.headerTitleText = headerTitleText;
    self.headerSubtitleText = headerSubtitleText;
    
    configureHeaderView();
    configureHeaderTitle();
    configureHeaderSubtitle();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  private func configureHeaderView() {
    self.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1);
    self.clipsToBounds = true;
    self.layer.cornerRadius = 40;
    self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner];
  };
};

extension Header {
  private func configureHeaderTitle() {
    addSubview(headerTitle);
    
    headerTitle.translatesAutoresizingMaskIntoConstraints = false;
    headerTitle.font = .systemFont(ofSize: 40);
    headerTitle.text = headerTitleText;
    headerTitle.textColor = .darkGray;
    headerTitle.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      headerTitle.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 2),
      headerTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: headerTitle.trailingAnchor, multiplier: 2)
    ]);
  };
  
  private func configureHeaderSubtitle() {
    addSubview(headerSubtitle);
    
    headerSubtitle.translatesAutoresizingMaskIntoConstraints = false;
    headerSubtitle.font = .preferredFont(forTextStyle: .title2);
    headerSubtitle.text = headerSubtitleText;
    headerSubtitle.textColor = .darkGray;
    headerSubtitle.numberOfLines = 0;
    
    NSLayoutConstraint.activate([
      headerSubtitle.topAnchor.constraint(equalToSystemSpacingBelow: headerTitle.bottomAnchor, multiplier: 3),
      headerSubtitle.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: headerSubtitle.trailingAnchor, multiplier: 2)
    ]);
  };
};


