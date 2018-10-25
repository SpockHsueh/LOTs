//
//  GlobalConstants.swift
//  LOTs
//
//  Created by 乃方 on 2018/10/24.
//  Copyright © 2018年 Nia. All rights reserved.
//

import UIKit

extension GlobalConstants {
    
    enum CardVerticalExpandingStyle {
        /// Expanding card pinning at the top of animatingContainerView
        case fromTop
        
        /// Expanding card pinning at the center of animatingContainerView
        case fromCenter
    }
    
    enum CardHorizontalExpandingStyle {
        /// Expanding card pinning at the top of animatingContainerView
        case fromLeading
        
        /// Expanding card pinning at the center of animatingContainerView
        case fromCenter
    }
    
}

enum GlobalConstants {
    
    static let cardHighlightedFactor: CGFloat = 0.96
    static let statusBarAnimationDuration: TimeInterval = 0.4
    static let cardCornerRadius: CGFloat = 16
    static let dismissalAnimationDuration = 1.6
    
    static let cardVerticalExpandingStyle: CardVerticalExpandingStyle = .fromTop
    static let cardHorizontalExpandingStyle: CardHorizontalExpandingStyle = .fromLeading
    
    /// Without this, there'll be weird offset (probably from scrollView) that obscures the card content view of the cardDetailView.
    static let isEnabledWeirdTopInsetsFix = true
    
    /// If true, will draw borders on animating views.
    static let isEnabledDebugAnimatingViews = false
    
    /// If true, this will add a 'reverse' additional top safe area insets to make the final top safe area insets zero.
    static let isEnabledTopSafeAreaInsetsFixOnCardDetailViewController = false
    
    /// If true, will always allow user to scroll while it's animated.
    static let isEnabledAllowsUserInteractionWhileHighlightingCard = true
    
    static let isEnabledDebugShowTimeTouch = true

}
