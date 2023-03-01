//
//  SideOutAnimationController.swift
//  ShopApp
//
//  Created by Abduraxmon on 01/03/23.
//

import UIKit

final class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {return}
        
        let containerView = transitionContext.containerView
        let time = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: time) {
            fromView.center.y -= containerView.bounds.size.height
            fromView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } completion: { finished in
            transitionContext.completeTransition(finished)
        }
        
    }
    
    
}
