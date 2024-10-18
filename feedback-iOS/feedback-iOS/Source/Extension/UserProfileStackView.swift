//
//  UserProfileView.swift
//  feedback-iOS
//
//  Created by Chandrala on 10/14/24.
//

import UIKit

import SnapKit
import Then

public class UserProfileStackView: UIStackView {
  
  var userImageLabel = UILabel()
  var userNameLabel = UILabel()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    
    setStyle()
    setUI()
    setAutoLayout()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    
    setStyle()
    setUI()
    setAutoLayout()
  }
  
  func setStyle() {
    userImageLabel.do {
      $0.text = "R"
      $0.font = UIFont.sfPro(.title2)
      $0.textColor = .white
      $0.backgroundColor = .lightGray
      $0.textAlignment = .center
      $0.roundCorners(cornerRadius: 31)
    }
    
    userNameLabel.do {
      $0.text = "Rama"
      $0.font = UIFont.sfPro(.header)
      $0.textColor = .black
      $0.textAlignment = .center
    }
    
    self.do {
      $0.axis = .vertical
      $0.alignment = .center
      $0.spacing = 5
    }
  }
  
  func setUI() {
    
    self.addArrangedSubview(userImageLabel)
    self.addArrangedSubview(userNameLabel)
  }
  
  func setAutoLayout() {
    userImageLabel.snp.makeConstraints {
      $0.height.width.equalTo(62)
    }
  }
}
