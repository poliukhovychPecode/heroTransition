import UIKit

class HeroNavigationDelegate: NSObject, UINavigationControllerDelegate {
    var originImageView: UIImageView!
    var originLabel: UILabel!
    var transitionType: TransitionType = .hero
    
    private let heroAnimator = HeroPushAnimator()
    private let fadeScaleAnimator = FadeScaleAnimator()
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch transitionType {
        case .hero:
            if (operation == .push || operation == .pop),
               (fromVC is HomeViewController || toVC is HomeViewController) {
                heroAnimator.isPresenting = (operation == .push)
                heroAnimator.originImageView = originImageView
                heroAnimator.originLabel = originLabel
                return heroAnimator
            }
        case .fadeScale:
            if operation == .push {
                fadeScaleAnimator.isPresenting = true
                return fadeScaleAnimator
            } else if operation == .pop {
                fadeScaleAnimator.isPresenting = false
                return fadeScaleAnimator
            }
        }
        
        return nil
    }
}
