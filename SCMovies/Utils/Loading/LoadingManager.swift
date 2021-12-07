//
//  LoadingManager.swift
//  SCMovies
//
//  Created by Aung Phyoe on 7/12/21.
//

import Foundation
import UIKit
import SwiftUI

/**
 Show Loading
 
 ### Usage Example: with inside View ###
 ````
 /// Show loading
 LoadingManager.share.showLoading(self.view)
 /// Change Color
 LoadingManager.share.showLoading(self.view, loaderColor: .white)
 
 /// Hide-Stop loading
 LoadingManager.share.stopLoading
 ````
 ### Usage Example: BLOCK ENTIRE SCREEN ###
 ````
 /// Show loading
 LoadingManager.share.showLoading()
 
 /// Hide-Stop loading
 LoadingManager.share.stopLoading
 ```
 */

class LoadingManager: NSObject {
    static let share = LoadingManager()
    
    lazy var loader: FadeSprinLoader = {
        let view = FadeSprinLoader(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 60, height: 60)))
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.isUserInteractionEnabled = true
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    func showLoading(_ view: UIView? = nil, loaderColor: UIColor = .green.withAlphaComponent(0.4)
    ) {
        stopLoading()
        loader.loaderColor = loaderColor
        guard let view = view else {
            if let window = UIApplication.topController() {
                window.view.addSubview(containerView)
                window.view.bringSubviewToFront(containerView)
                containerView.addSubview(loader)
                containerView.snp.makeConstraints { (make) -> Void in
                    make.edges.equalToSuperview()
                }
            }
            return
        }
        view.addSubview(containerView)
        view.bringSubviewToFront(containerView)
        containerView.addSubview(loader)
        containerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    func stopLoading() {
        self.loader.removeFromSuperview()
        self.containerView.removeFromSuperview()
    }
}
