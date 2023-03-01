//
//  DetailVC.swift
//  ShopApp
//
//  Created by Abduraxmon on 01/03/23.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var typeValue: UILabel!
    @IBOutlet weak var genreType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = UIColor.clear
        let gradientView = GradiantView(frame: CGRect.zero)
        gradientView.frame = CGRect(x: 0, y: 0, width: view.frame.width + 30, height: view.frame.height + 45)
        view.insertSubview(gradientView, at: 0)
        
    }
    
    @objc func handleTap() {
        dismiss(animated: true)
    }
    
    @IBAction func quitPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    

}

extension DetailVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
}
