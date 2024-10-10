//
//  SessionManager.swift
//  feedback-iOS
//
//  Created by Chandrala on 10/11/24.
//

import MultipeerConnectivity

final class SessionManager: NSObject {
  
  static let shared = SessionManager()
  
  var peerID: MCPeerID!
  var session: MCSession!
  var advertiser: MCNearbyServiceAdvertiser?
  var browser: MCBrowserViewController?
  
  var isHost: Bool = false
  
  var onPeersChanged: (() -> Void)?
  var onDataReceived: ((Data, MCPeerID) -> Void)?
  
  private let serviceType = "feedbacksession"
  
  private override init() {
    super.init()
  }
  
  func setSession(isHost: Bool, displayName: String, delegate: MCBrowserViewControllerDelegate? = nil) {
    self.isHost = isHost
    peerID = MCPeerID(displayName: displayName)
    session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
    session.delegate = self
    
    if isHost {
      setAdvertiser()
    } else {
      setBrowser(delegate: delegate)
    }
  }
  
  func allPeersIncludingHost() -> [MCPeerID] {
    return [peerID] + session.connectedPeers
  }
  
  private func setAdvertiser() {
    advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
    advertiser?.delegate = self
    advertiser?.startAdvertisingPeer()
  }
  
  private func setBrowser(delegate: MCBrowserViewControllerDelegate?) {
    browser = MCBrowserViewController(serviceType: serviceType, session: session)
    browser?.delegate = delegate
  }
  
  func sendData(_ data: Data) {
    guard !session.connectedPeers.isEmpty else { return }
    
    do {
      try session.send(data, toPeers: session.connectedPeers, with: .reliable)
      print("데이터 전송 성공")
    } catch {
      print("데이터 전송 실패: \(error.localizedDescription)")
    }
  }
}

// MARK: - MCSessionDelegate
extension SessionManager: MCSessionDelegate {
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
    case .connected:
      print("연결됨: \(peerID.displayName)")
    case .connecting:
      print("연결 중: \(peerID.displayName)")
    case .notConnected:
      print("연결 끊김: \(peerID.displayName)")
    @unknown default:
      fatalError("알 수 없는 상태")
    }
    
    DispatchQueue.main.async {
      self.onPeersChanged?()
    }
  }
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    DispatchQueue.main.async {
      self.onDataReceived?(data, peerID)
    }
  }
  
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
  
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
  
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}

// MARK: - MCBrowserViewControllerDelegate
extension SessionManager: MCBrowserViewControllerDelegate {
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true, completion: nil)
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true, completion: nil)
  }
}

// MARK: - MCNearbyServiceAdvertiserDelegate
extension SessionManager: MCNearbyServiceAdvertiserDelegate {
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    // 피어의 초대 처리
    invitationHandler(true, session) // 자동 수락 예시
  }
}
