//
//  FLNativeView.swift
//  Runner
//
//  Created by Ishteyaque Ahmad on 29/10/2024.
//

import Flutter
import UIKit
import JWPlayerKit
class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var playerController:JWPlayerViewController?

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        if let params = args as? [String:String]{
            configurePlayer(item: PlayerItem(urlString: params["urlString"] ?? "", mediaId: params["mediaId"] ?? "" ))
        }
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        let playerView = VideoPlayer.shared.getPlayerView()
        playerView.frame = _view.frame
        _view.addSubview(playerView)
    }
    
    
    private func configurePlayer(item:PlayerItem) {
        if let playerItem = self.getPLayerItem(item: item) {
            VideoPlayer.shared.setPlayer(item: playerItem)
        }
    }
    
    func getPLayerItem(item:PlayerItem) -> JWPlayerItem?{
        if let videoUrl = URL(string: item.urlString) {
            if let playerItem = try? JWPlayerItemBuilder().file(videoUrl).mediaId(item.mediaId).build() {
                return playerItem
            }
        }
        return nil
    }
}
struct PlayerItem{
    let urlString:String
    let mediaId:String
}

class VideoPlayer {
    static let shared = VideoPlayer()
    private var playerController:JWPlayerViewController!
    private var fullScreen:JWFullScreenViewController?
    private var isInitialized = false
    private init(){}
    func setPlayer(item:JWPlayerItem){
        if playerController == nil {
            playerController = JWPlayerViewController()
            playerController.delegate = self
        }
        if isInitialized {
            playerController?.player.stop()
            playerController?.player.loadPlaylist(items: [item])
        } else {
            do {
                let config = try JWPlayerConfigurationBuilder()
                    .playlist(items: [item]).autostart(true)
                    .build()
                playerController.player.configurePlayer(with: config)
                playerController.setVisibility(.hidden, for: [.languagesButton, .settingsButton,.nextButton,.previousButton,.pictureInPictureButton,.airplayButton])
                isInitialized = true
            } catch {
                
            }
        }
    }
    func getPlayerView()->UIView {
        if playerController == nil {
            return UIView(frame: .zero)
        }
        return playerController.view
    }
}

extension VideoPlayer:JWPlayerViewControllerDelegate {
    func playerViewControllerWillGoFullScreen(_ controller: JWPlayerKit.JWPlayerViewController) -> JWPlayerKit.JWFullScreenViewController? {
        if self.fullScreen == nil {
            fullScreen = JWFullScreenViewController()
        }
        return fullScreen
    }
    
    func playerViewControllerDidGoFullScreen(_ controller: JWPlayerKit.JWPlayerViewController) {
        
    }
    
    func playerViewControllerWillDismissFullScreen(_ controller: JWPlayerKit.JWPlayerViewController) {
        
    }
    
    func playerViewControllerDidDismissFullScreen(_ controller: JWPlayerKit.JWPlayerViewController) {
        //ChannelHandler.shared.fullScreenDismiss()
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, controlBarVisibilityChanged isVisible: Bool, frame: CGRect) {
        
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, sizeChangedFrom oldSize: CGSize, to newSize: CGSize) {
        
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, screenTappedAt position: CGPoint) {
        
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedMenuOpenedWithItems items: [JWPlayerKit.JWPlayerItem], withMethod method: JWPlayerKit.JWRelatedInteraction) {
        
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedMenuClosedWithMethod method: JWPlayerKit.JWRelatedInteraction) {
        
    }
    
    func playerViewController(_ controller: JWPlayerKit.JWPlayerViewController, relatedItemBeganPlaying item: JWPlayerKit.JWPlayerItem, atIndex index: Int, withMethod method: JWPlayerKit.JWRelatedInteraction) {
        
    }
    
    
}
