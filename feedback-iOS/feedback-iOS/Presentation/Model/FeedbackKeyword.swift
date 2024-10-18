//
//  FeedbackKeyword.swift
//  feedback-iOS
//
//  Created by Chandrala on 10/13/24.
//

import Foundation

struct Trait: Codable {
  let name: String
  let description: String
  var count: Int
  
  init(name: String, description: String, count: Int) {
    self.name = name
    self.description = description
    self.count = count
  }
}

struct Category: Codable {
  let name: String
  let description: String
  var traits: [Trait]
  
  init(name: String, description: String, traits: [Trait]) {
    self.name = name
    self.description = description
    self.traits = traits
  }
}

struct SkillSet: Codable {
  var categories: [Category]
  
  init(categories: [Category]) {
    self.categories = categories
  }
}

let communication = Category(
  name: "의사소통 (Communication)",
  description: "상대방과 효과적으로 소통하는 능력을 의미합니다.",
  traits: [
    Trait(name: "명확한 (Clear)", description: "상대방이 쉽게 이해할 수 있도록 명확하게 전달한다.", count: 0),
    Trait(name: "설득력 있는 (Persuasive)", description: "논리적이고 설득력 있게 상대방을 이끌어낸다.", count: 0),
    Trait(name: "공감하는 (Empathetic)", description: "상대방의 감정을 이해하고 그에 맞는 대응을 한다.", count: 0),
    Trait(name: "적극적인 (Assertive)", description: "자신의 생각을 명확히 표현하며, 소극적이지 않다.", count: 0),
    Trait(name: "경청하는 (Attentive)", description: "상대방의 말을 잘 듣고, 그에 따른 적절한 반응을 보여준다.", count: 0),
  ]
)

let selfDevelopment = Category(
  name: "자기개발 (Self-Development)",
  description: "자신의 성장을 위해 지속적으로 배우고 발전하는 능력입니다.",
  traits: [
    Trait(name: "자기주도적인 (Self-driven)", description: "스스로 동기부여를 하고, 독립적으로 학습한다.", count: 0),
    Trait(name: "목표 지향적인 (Goal-oriented)", description: "명확한 목표를 설정하고, 이를 위해 행동한다.", count: 0),
    Trait(name: "끊임없이 배우는 (Lifelong learner)", description: "평생 학습을 실천하며, 지속적인 발전을 추구한다.", count: 0),
    Trait(name: "도전적인 (Challenging)", description: "새로운 도전을 두려워하지 않고, 성장을 위해 노력한다.", count: 0),
    Trait(name: "책임감 있는 (Responsible)", description: "자기 발전에 책임을 지고, 꾸준히 개선해 나간다.", count: 0),
  ]
)

let problemSolving = Category(
  name: "문제해결 (Problem Solving)",
  description: "창의적이고 분석적인 사고를 통해 문제를 해결하는 능력입니다.",
  traits: [
    Trait(name: "창의적인 (Creative)", description: "문제에 대한 창의적인 해결책을 제시한다.", count: 0),
    Trait(name: "분석적인 (Analytical)", description: "문제를 세밀하게 분석하고 해결책을 찾는다.", count: 0),
    Trait(name: "유연한 (Flexible)", description: "다양한 해결책을 탐색하며, 상황 변화에 유연하게 대처한다.", count: 0),
    Trait(name: "객관적인 (Objective)", description: "감정에 휘둘리지 않고 논리적으로 문제를 해결한다.", count: 0),
    Trait(name: "협력적인 (Collaborative)", description: "다른 사람들과 협력하여 문제 해결에 기여한다.", count: 0)
  ]
)

let teamwork = Category(
  name: "팀워크 (Teamwork)",
  description: "팀 내에서 협력하고 소통하며, 공동 목표를 달성하는 능력입니다.",
  traits: [
    Trait(name: "조율하는 (Mediative)", description: "팀 내 갈등을 조율하고, 원활한 소통을 이끈다.", count: 0),
    Trait(name: "포용적인 (Inclusive)", description: "다양한 의견과 배경을 가진 사람들을 존중하며 포용한다.", count: 0),
    Trait(name: "긍정적인 (Positive)", description: "긍정적인 에너지로 팀 분위기를 좋게 만든다.", count: 0),
    Trait(name: "성실한 (Diligent)", description: "팀의 목표 달성을 위해 성실하게 참여한다.", count: 0),
    Trait(name: "의사소통이 원활한 (Communicative)", description: "팀 내에서 원활한 소통을 이끌어낸다.", count: 0)
  ]
)

let leadership = Category(
  name: "리더십 (Leadership)",
  description: "팀을 이끌고 동기부여하며, 전략적으로 목표를 달성하는 능력입니다.",
  traits: [
    Trait(name: "영감을 주는 (Inspirational)", description: "팀원들에게 동기를 부여하고 영감을 준다.", count: 0),
    Trait(name: "결단력 있는 (Decisive)", description: "중요한 순간에 빠르고 정확하게 결정을 내린다.", count: 0),
    Trait(name: "책임감 있는 (Responsible)", description: "자신의 결정과 행동에 대해 책임을 진다.", count: 0),
    Trait(name: "포용적인 (Inclusive)", description: "다양한 의견과 배경을 가진 사람들을 포용하며 이끈다.", count: 0),
    Trait(name: "동기부여하는 (Motivating)", description: "팀원들에게 동기를 부여하고, 목표를 달성하도록 격려한다.", count: 0)
  ]
)
