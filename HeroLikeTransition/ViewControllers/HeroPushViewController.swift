import UIKit

class HeroPushViewController: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()

    var image: UIImage?
    var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Transition"

        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 300)
        view.addSubview(imageView)

        titleLabel.text = titleText
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 20, y: 420, width: view.bounds.width - 40, height: 30)
        view.addSubview(titleLabel)

        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        view.addGestureRecognizer(tap)
    }

    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
