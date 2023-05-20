//
//  AvatarCell.swift
//  Login
//
//  Created by João Pedro on 15/05/23.
//

import UIKit

class AvatarCell: UITableViewCell {
  let avatarImage = UIImageView();
  let avatarName = UILabel();
  let avatarType = UILabel();
  let avatarLocation = UILabel();
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    
    backgroundColor = .darkGray;
    
    configureAvatarImage();
    configureAvatarName();
    configureAvatarType();
    configureAvatarLocation();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
  
  func set(avatar: Avatar) {
    DispatchQueue.global().async {
      let dataImage = try? Data(contentsOf: URL(string: avatar.image)!);
      DispatchQueue.main.async {
        self.avatarImage.image = UIImage(data: dataImage!);
      };
    };
    
    avatarName.text = avatar.name;
    avatarType.text = avatar.type == "" ? "??????" : avatar.type;
    avatarLocation.text = avatar.location.name != "" ? avatar.location.name : "Whereabouts unknown"
  };
};


// MARK: Styles
extension AvatarCell {
  private func configureAvatarImage() {
    addSubview(avatarImage);
    
    avatarImage.translatesAutoresizingMaskIntoConstraints = false;
    avatarImage.contentMode = .scaleAspectFit;
    avatarImage.clipsToBounds = true;
    avatarImage.layer.cornerRadius = 15;
    
    NSLayoutConstraint.activate([
      avatarImage.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarImage.widthAnchor.constraint(equalToConstant: 150),
      avatarImage.heightAnchor.constraint(equalToConstant: 150),
      avatarImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
    ]);
  };
  
  private func configureAvatarName() {
    addSubview(avatarName);
    
    avatarName.translatesAutoresizingMaskIntoConstraints = false;
    avatarName.font = .preferredFont(forTextStyle: .title1);
    avatarName.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1);
    avatarName.numberOfLines = 0;
    avatarName.adjustsFontForContentSizeCategory = true;
    
    NSLayoutConstraint.activate([
      avatarName.topAnchor.constraint(equalToSystemSpacingBelow: avatarImage.topAnchor, multiplier: 0),
      avatarName.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImage.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: avatarName.trailingAnchor, multiplier: 2)
    ]);
  };
  
  private func configureAvatarType() {
    addSubview(avatarType);
    
    avatarType.translatesAutoresizingMaskIntoConstraints = false;
    avatarType.font = .preferredFont(forTextStyle: .title3);
    avatarType.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1);
    avatarType.numberOfLines = 0;
    avatarName.adjustsFontForContentSizeCategory = true;
    
    NSLayoutConstraint.activate([
      avatarType.topAnchor.constraint(equalToSystemSpacingBelow: avatarName.bottomAnchor, multiplier: 1),
      avatarType.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImage.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: avatarType.trailingAnchor, multiplier: 2)
    ]);
  };
  
  private func configureAvatarLocation() {
    addSubview(avatarLocation);
    
    avatarLocation.translatesAutoresizingMaskIntoConstraints = false;
    avatarLocation.font = .preferredFont(forTextStyle: .title3);
    avatarLocation.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1);
    avatarLocation.adjustsFontForContentSizeCategory = true;
    
    NSLayoutConstraint.activate([
      avatarLocation.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImage.trailingAnchor, multiplier: 2),
      trailingAnchor.constraint(equalToSystemSpacingAfter: avatarLocation.trailingAnchor, multiplier: 2),
      avatarLocation.bottomAnchor.constraint(equalToSystemSpacingBelow: avatarImage.bottomAnchor, multiplier: 0)
    ]);
  };
};
