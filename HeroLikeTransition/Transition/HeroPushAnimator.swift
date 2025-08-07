
import UIKit

class HeroPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var isPresenting = true
    var originImageView: UIImageView!
    var originLabel: UILabel!

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        if isPresenting {
            guard let toVC = transitionContext.viewController(forKey: .to) as? HeroPushViewController else {
                transitionContext.completeTransition(false)
                return
            }

            let imageSnapshot = UIImageView(image: originImageView.image)
            imageSnapshot.contentMode = .scaleAspectFill
            imageSnapshot.clipsToBounds = true
            imageSnapshot.frame = container.convert(originImageView.bounds, from: originImageView)

            let labelSnapshot = UILabel()
            labelSnapshot.text = originLabel.text
            labelSnapshot.font = originLabel.font
            labelSnapshot.textColor = originLabel.textColor
            labelSnapshot.frame = container.convert(originLabel.bounds, from: originLabel)

            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.alpha = 0
            toVC.imageView.isHidden = true
            toVC.titleLabel.isHidden = true

            container.addSubview(toVC.view)
            container.addSubview(imageSnapshot)
            container.addSubview(labelSnapshot)

            UIView.animate(withDuration: duration, animations: {
                imageSnapshot.frame = container.convert(toVC.imageView.bounds, from: toVC.imageView)
                labelSnapshot.frame = container.convert(toVC.titleLabel.bounds, from: toVC.titleLabel)
                toVC.view.alpha = 1
            }) { _ in
                toVC.imageView.isHidden = false
                toVC.titleLabel.isHidden = false
                imageSnapshot.removeFromSuperview()
                labelSnapshot.removeFromSuperview()
                transitionContext.completeTransition(true)
            }

        } else {
            guard let fromVC = transitionContext.viewController(forKey: .from) as? HeroPushViewController else {
                transitionContext.completeTransition(false)
                return
            }

            let imageSnapshot = UIImageView(image: fromVC.imageView.image)
            imageSnapshot.contentMode = .scaleAspectFill
            imageSnapshot.clipsToBounds = true
            imageSnapshot.frame = container.convert(fromVC.imageView.bounds, from: fromVC.imageView)

            let labelSnapshot = UILabel()
            labelSnapshot.text = fromVC.titleLabel.text
            labelSnapshot.font = fromVC.titleLabel.font
            labelSnapshot.textColor = fromVC.titleLabel.textColor
            labelSnapshot.frame = container.convert(fromVC.titleLabel.bounds, from: fromVC.titleLabel)

            fromVC.imageView.isHidden = true
            fromVC.titleLabel.isHidden = true

            if let toVC = transitionContext.viewController(forKey: .to) {
                container.insertSubview(toVC.view, belowSubview: fromVC.view)
            }

            container.addSubview(imageSnapshot)
            container.addSubview(labelSnapshot)

            UIView.animate(withDuration: duration, animations: {
                imageSnapshot.frame = container.convert(self.originImageView.bounds, from: self.originImageView)
                labelSnapshot.frame = container.convert(self.originLabel.bounds, from: self.originLabel)
                fromVC.view.alpha = 0
            }) { _ in
                imageSnapshot.removeFromSuperview()
                labelSnapshot.removeFromSuperview()
                fromVC.imageView.isHidden = false
                fromVC.titleLabel.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
