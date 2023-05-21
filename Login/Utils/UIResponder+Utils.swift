//
//  UIResponder+Utils.swift
//  Login
//
//  Created by João Pedro on 21/05/23.
//

import UIKit

extension UIResponder {
  private struct Static {
    static weak var responder: UIResponder?
  };

  static func currentFirst() -> UIResponder? {
    Static.responder = nil;
    UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil);
    
    return Static.responder;
  };
  
  @objc private func trap() {
    Static.responder = self;
  };
};
