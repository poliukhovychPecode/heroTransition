import UIKit

class FadeScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = true

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        if isPresenting {
            guard let toVC = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
            }

            toVC.view.alpha = 0
            toVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            container.addSubview(toVC.view)

            UIView.animate(withDuration: duration, animations: {
                toVC.view.alpha = 1
                toVC.view.transform = .identity
            }) { _ in
                transitionContext.completeTransition(true)
            }

        } else {
            guard let fromVC = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
            }

            UIView.animate(withDuration: duration, animations: {
                fromVC.view.alpha = 0
                fromVC.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { _ in
                fromVC.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
