import UIKit

enum TransitionType {
    case hero, fadeScale
}

class HomeViewController: UIViewController {

    let imageView = UIImageView(image: UIImage(named: "logo"))
    let titleLabel = UILabel()

    let imageView2 = UIImageView(image: UIImage(named: "logo"))
    let titleLabel2 = UILabel()

    private let navDelegate = HeroNavigationDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"

        setupFirstCard()
//        setupSecondCard()

        navigationController?.delegate = navDelegate
    }

    private func setupFirstCard() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 100, y: 180, width: 150, height: 150)
        view.addSubview(imageView)

        titleLabel.text = "Hero Transition"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.frame = CGRect(x: 100, y: 340, width: 200, height: 30)
        view.addSubview(titleLabel)

        let tap = UITapGestureRecognizer(target: self, action: #selector(pushHeroTransition))
        imageView.addGestureRecognizer(tap)
    }

    private func setupSecondCard() {
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        imageView2.isUserInteractionEnabled = true
        imageView2.frame = CGRect(x: 100, y: 420, width: 150, height: 150)
        view.addSubview(imageView2)

        titleLabel2.text = "Fade+Scale Transition"
        titleLabel2.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel2.textColor = .black
        titleLabel2.frame = CGRect(x: 100, y: 580, width: 220, height: 30)
        view.addSubview(titleLabel2)

        let tap2 = UITapGestureRecognizer(target: self, action: #selector(pushFadeScaleTransition))
        imageView2.addGestureRecognizer(tap2)
    }

    @objc private func pushHeroTransition() {
        let pushVC = HeroPushViewController()
        pushVC.image = imageView.image
        pushVC.titleText = titleLabel.text

        navDelegate.originImageView = imageView
        navDelegate.originLabel = titleLabel
        navDelegate.transitionType = .hero

        navigationController?.pushViewController(pushVC, animated: true)
    }

    @objc private func pushFadeScaleTransition() {
        let fadeVC = HeroPushViewController()
        fadeVC.image = imageView2.image
        fadeVC.titleText = titleLabel2.text

        navDelegate.transitionType = .fadeScale

        navigationController?.pushViewController(fadeVC, animated: true)
    }
}
