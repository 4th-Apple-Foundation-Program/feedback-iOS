//
//  TestViewController.swift
//  feedback-iOS
//
//  Created by 이빈 on 10/16/24.
//

import UIKit

import SnapKit
import Then

class FeedbackDetailViewController: UIViewController {
  
  var skill = SkillSet(categories: [communication, selfDevelopment, problemSolving, teamwork, leadership])
  
  var selectedUserInfo: UserInfo?
  
  let scrollView = UIScrollView()
  let contentView = UIView()
  
  let userName = UILabel()
  let userRole = UILabel()
  
  var lastComponent: UIView? = nil
  
  let doneButton = UIBarButtonItem()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setStyle()
    setUI()
    setAutoLayout()
  }
  
  private func setStyle() {
    view.backgroundColor = .white
    
    self.title = "Feedback"
    self.navigationItem.rightBarButtonItem = doneButton
    
    scrollView.do {
      $0.showsVerticalScrollIndicator = true
    }
    
    userName.do {
      $0.text = selectedUserInfo?.peerID
      $0.font = UIFont.sfPro(.title2)
    }
    
    userRole.do {
      $0.text = selectedUserInfo?.role
      $0.font = UIFont.sfPro(.body)
    }
    
    doneButton.do {
      $0.title = "Done"
      $0.style = .done
      $0.target = self
      $0.action = #selector(doneButtonTapped)
      $0.isEnabled = false
    }
    
  }
  
  private func setUI() {
    contentView.addSubviews(userName, userRole)
    scrollView.addSubviews(contentView)
    view.addSubview(scrollView)
    
    // 카테고리별로 FeedbackSelectionComponent를 생성하고 contentView에 추가
    for (index, category) in skill.categories.enumerated() {
      let feedbackComponent = FeedbackSelectionComponent(name: category.name, traits: category.traits)
      feedbackComponent.parentViewController = self
      contentView.addSubview(feedbackComponent)
      
      // AutoLayout 설정 (컴포넌트 간격은 22)
      feedbackComponent.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview().inset(20)
        if index == 0 {
          $0.top.equalTo(userRole.snp.bottom).offset(16)
        } else {
          let previousComponent = contentView.subviews[contentView.subviews.firstIndex(of: feedbackComponent)! - 1]
          $0.top.equalTo(previousComponent.snp.bottom).offset(22)
        }
      }
      lastComponent = feedbackComponent
    }
    lastComponent?.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-20) // 마지막 컴포넌트는 contentView의 하단에 맞춤
    }
  }
  
  private func setAutoLayout() {
    
    scrollView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
    
    contentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
    }
    
    userName.snp.makeConstraints {
      $0.top.equalToSuperview().offset(120)
      $0.centerX.equalToSuperview()
    }
    
    userRole.snp.makeConstraints {
      $0.top.equalTo(userName.snp.bottom).offset(5)
      $0.centerX.equalToSuperview()
    }
  }
  
  func updateTraitSelection(categoryIndex: Int, traitIndex: Int, increase: Bool) {
    if increase {
      skill.categories[categoryIndex].traits[traitIndex].count += 1
    } else {
      skill.categories[categoryIndex].traits[traitIndex].count -= 1
    }
  }
  
  func updateDoneButtonState() {
    for subview in contentView.subviews {
      if let feedbackComponent = subview as? FeedbackSelectionComponent {
        if feedbackComponent.selectedTraitsTitles.count != feedbackComponent.maxSelectableTraits {
          doneButton.isEnabled = false
          return
        }
      }
    }
    doneButton.isEnabled = true
  }
  
  @objc private func doneButtonTapped() {
//    print(skill)
    
    
    if let selectedUserInfo = selectedUserInfo {
      do {
        if let targetPeerID = SessionManager.shared.session.connectedPeers.first(where: { $0.displayName == selectedUserInfo.peerID }) {
          
          let selectedFeedbacksData = try JSONEncoder().encode(skill)
          
          SessionManager.shared.sendData(selectedFeedbacksData, message: "sendFeedback", to: [targetPeerID])
        } else {
          print("해당 피어를 찾을 수 없습니다.")
        }
      } catch {
        print("데이터 인코딩 실패: \(error.localizedDescription)")
      }
    }
    dismiss(animated: true, completion: nil)
  }
}
