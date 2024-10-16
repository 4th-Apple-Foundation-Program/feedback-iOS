//
//  UILabel+.swift
//  feedback-iOS
//
//  Created by Chandrala on 10/9/24.
//

import UIKit

extension UILabel {
  func setText(
    _ text: String = " ",
    style: UIFont.SFPro,
    color: UIColor = .black,
    isSingleLine: Bool = false
  ) {
    attributedText = .sfProString(text.isEmpty ? " " : text, style: style)
    textColor = color
    if isSingleLine {
      numberOfLines = 1
      lineBreakMode = .byTruncatingTail
    } else {
      numberOfLines = 0
    }
  }
  
  func updateText(_ text: String?) {
    guard let currentAttributes = attributedText?.attributes(at: 0, effectiveRange: nil) else {
      self.text = text
      return
    }
    attributedText = NSAttributedString(string: text ?? " ", attributes: currentAttributes)
  }
  
  func setHighlightText(_ words: String..., style: UIFont.SFPro, color: UIColor? = nil) {
    guard let currentAttributedText = attributedText else { return }
    
    let mutableAttributedString = NSMutableAttributedString(attributedString: currentAttributedText)
    let textColor = textColor ?? .black
    
    for word in words {
      let range = (currentAttributedText.string as NSString).range(of: word)
      
      if range.location != NSNotFound {
        let highlightedAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.sfPro(style),
          .foregroundColor: color ?? textColor
        ]
        mutableAttributedString.addAttributes(highlightedAttributes, range: range)
        attributedText = mutableAttributedString
      }
    }
  }
}

