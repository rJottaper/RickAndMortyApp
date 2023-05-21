//
//  LoginViewController.swift
//  Login
//
//  Created by João Pedro on 30/04/23.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func didLogin();
};

extension LoginViewController {
  @objc func keyboardWillShow(sender: NSNotification) {
    guard let userInfo = sender.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
          let currentTextField = UIResponder.currentFirst() as? UITextField else { return };
    
    let keyboardTopY = keyboardFrame.cgRectValue.origin.y;
    let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview);
    let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height;
    
    if (textFieldBottomY > keyboardTopY) {
      let textBoxY = convertedTextFieldFrame.origin.y;
      let newFrameY = (textBoxY - keyboardTopY / 1.3) * -1;
      view.frame.origin.y = newFrameY;
    };
  };
  
  @objc func keyboardWillHide(sender: NSNotification) {
      view.frame.origin.y = 0
  };
};

class LoginViewController: UIViewController {
  let imageLogin = UIImageView();
  let loginView = LoginView();
  
  let screenHeight =  UIScreen.main.bounds.height;
  
  var email: String? {
    return loginView.emailTextField.text;
  };
  
  var password: String? {
    return loginView.passwordTextField.text;
  };
  
  weak var delegate: LoginViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad();
    view.backgroundColor = .darkGray;
    
    loginView.loginHandler = self;
    
    print(UIScreen.main.bounds.height);
    
    configureLayout();
  };
};

extension LoginViewController {
  private func configureLayout() {
    configureImageLogin();
    configureLoginView();
    setupKeyboarding();
  };
  
  func setupKeyboarding() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
  };
  
  func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
    return emailPred.evaluate(with: email);
  };
  
  func showAlerts(type: String) {
    let alertFieldsEmpty = UIAlertController(title: "Attention", message: type == "isEmpty" ? "Fields cannot be empty" : "Enter a correct email address", preferredStyle: .alert);
    alertFieldsEmpty.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
    
    self.present(alertFieldsEmpty, animated: true, completion: nil);
  };
};

extension LoginViewController: LoginViewDelegate {
  func loginButtonTapped() {
    guard let email = email, let password = password else {
      print("Here");
      return;
    };
    
    if (email.isEmpty || password.isEmpty) {
      showAlerts(type: "isEmpty");
    } else {
      if (isValidEmail(email: email) == true) {
        if (email == "rjoao.dev@gmail.com" && password == "12345") {
          delegate?.didLogin();
        };
      } else {
        showAlerts(type: "isEmail");
      };
    };
  };
};

// MARK: Styles
extension LoginViewController {
  private func configureImageLogin() {
    view.addSubview(imageLogin);
    
    imageLogin.translatesAutoresizingMaskIntoConstraints = false;
    imageLogin.contentMode = .scaleAspectFit;
    imageLogin.image = UIImage(named: "login");
    
    NSLayoutConstraint.activate([
      imageLogin.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 4),
      imageLogin.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: imageLogin.trailingAnchor, multiplier: 2),
      imageLogin.heightAnchor.constraint(equalToConstant: screenHeight < 670.0 ? screenHeight / 3.5 : screenHeight / 3)
    ]);
  };
  
  private func configureLoginView() {
    view.addSubview(loginView);
    
    loginView.translatesAutoresizingMaskIntoConstraints = false;
    loginView.preservesSuperviewLayoutMargins = true;
    
    NSLayoutConstraint.activate([
      loginView.topAnchor.constraint(equalToSystemSpacingBelow: imageLogin.bottomAnchor, multiplier: 6),
      loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
      view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 0),
    ]);
  };
};
