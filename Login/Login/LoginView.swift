//
//  LoginView.swift
//  Login
//
//  Created by João Pedro on 01/05/23.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
  func loginButtonTapped();
};

class LoginView: UIView {
  let loginText = UILabel();
  
  let emailText = UILabel();
  let passwordText = UILabel();
  
  let emailTextField = UITextField();
  let passwordTextField = UITextField();
  
  let buttonLogin = UIButton(type: .system);
  
  weak var loginHandler: LoginViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    
    backgroundColor = .init(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1);
    clipsToBounds = true;
    layer.cornerRadius = 40;
    layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner];
    
    configureLoginText();
    configureEmailText();
    configureEmailTextField();
    configurePasswordText();
    configurePasswordTextField();
    configureButtonLogin();
  };
  
  override func layoutSubviews() {
    super.layoutSubviews();
    
    configureEmailTextField();
    configurePasswordTextField();
  };
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented");
  };
};

extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    emailTextField.endEditing(true);
    passwordTextField.endEditing(true);
    
    return true
  };
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true;
  };
  
  @objc func buttonLoginHasTap() {
    loginHandler?.loginButtonTapped();
  };
};

// MARK: - Styles

extension LoginView {
  private func configureLoginText() {
    addSubview(loginText)
    
    loginText.translatesAutoresizingMaskIntoConstraints = false;
    loginText.font = .systemFont(ofSize: 32);
    loginText.text = "Log-in";
    loginText.textColor = .darkGray;
    loginText.adjustsFontForContentSizeCategory = true;
    
    NSLayoutConstraint.activate([
      loginText.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 4),
      loginText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 4),
      trailingAnchor.constraint(equalToSystemSpacingAfter: loginText.trailingAnchor, multiplier: 2),
    ]);
  };
  
  private func configureEmailText() {
    addSubview(emailText);
    
    emailText.translatesAutoresizingMaskIntoConstraints = false;
    emailText.font = .preferredFont(forTextStyle: .title2);
    emailTextField.adjustsFontForContentSizeCategory = true;
    emailText.text = "Email";
    emailText.textColor = .darkGray;
    
    NSLayoutConstraint.activate([
      emailText.topAnchor.constraint(equalToSystemSpacingBelow: loginText.bottomAnchor, multiplier: 4),
      emailText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 7),
      trailingAnchor.constraint(equalToSystemSpacingAfter: emailText.trailingAnchor, multiplier: 7)
    ]);
  };
  
  private func configureEmailTextField() {
    addSubview(emailTextField);
    
    emailTextField.translatesAutoresizingMaskIntoConstraints = false;
    emailTextField.attributedPlaceholder = NSAttributedString(string: "Your Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]);
    emailTextField.borderStyle = UITextField.BorderStyle.none;
    emailTextField.textColor = .darkGray;
    emailTextField.delegate = self;
    emailTextField.adjustsFontForContentSizeCategory = true;
    
    let bottomLine = CALayer();
    bottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1.0);
    bottomLine.backgroundColor = UIColor.darkGray.cgColor;
    
    emailTextField.layer.addSublayer(bottomLine);
    
    NSLayoutConstraint.activate([
      emailTextField.topAnchor.constraint(equalToSystemSpacingBelow: emailText.bottomAnchor, multiplier: 1),
      emailTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 7),
      trailingAnchor.constraint(equalToSystemSpacingAfter: emailTextField.trailingAnchor, multiplier: 7),
      emailTextField.heightAnchor.constraint(equalToConstant: 30)
    ]);
  };
  
  private func configurePasswordText() {
    addSubview(passwordText);
    
    passwordText.translatesAutoresizingMaskIntoConstraints = false;
    passwordText.font = .preferredFont(forTextStyle: .title2);
    passwordText.text = "Password";
    passwordText.textColor = .darkGray;
    passwordText.adjustsFontForContentSizeCategory = true;
    
    NSLayoutConstraint.activate([
      passwordText.topAnchor.constraint(equalToSystemSpacingBelow: emailTextField.bottomAnchor, multiplier: 3),
      passwordText.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 7),
      trailingAnchor.constraint(equalToSystemSpacingAfter: passwordText.trailingAnchor, multiplier: 7)
    ]);
  };
  
  private func configurePasswordTextField() {
    addSubview(passwordTextField);
    
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false;
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "Your Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]);
    passwordTextField.textColor = .darkGray;
    passwordTextField.borderStyle = UITextField.BorderStyle.none;
//    passwordTextField.enablePasswordToggle();
    passwordTextField.isSecureTextEntry = true;
    passwordTextField.delegate = self;

    let bottomLine = CALayer();
    bottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 1.0);
    bottomLine.backgroundColor = UIColor.darkGray.cgColor;
    
    passwordTextField.layer.addSublayer(bottomLine);
    
    NSLayoutConstraint.activate([
      passwordTextField.topAnchor.constraint(equalToSystemSpacingBelow: passwordText.bottomAnchor, multiplier: 1),
      passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 7),
      trailingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 7),
      passwordTextField.heightAnchor.constraint(equalToConstant: 30)
    ]);
  };
  
  private func configureButtonLogin() {
    addSubview(buttonLogin);
    
    buttonLogin.translatesAutoresizingMaskIntoConstraints = false;
    buttonLogin.backgroundColor = .darkGray;
    buttonLogin.layer.cornerRadius = 10;
    buttonLogin.setTitle("Login", for: .normal);
    buttonLogin.setTitleColor(.init(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1), for: .normal);
    buttonLogin.addTarget(self, action: #selector(buttonLoginHasTap), for: .touchUpInside);
    
    NSLayoutConstraint.activate([
      buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
      buttonLogin.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 7),
      trailingAnchor.constraint(equalToSystemSpacingAfter: buttonLogin.trailingAnchor, multiplier: 7),
      buttonLogin.heightAnchor.constraint(equalToConstant: 50)
    ]);
  };
};
