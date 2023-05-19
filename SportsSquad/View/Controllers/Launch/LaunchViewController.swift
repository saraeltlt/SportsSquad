
//
//  LaunchViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 18/05/2023.
//

import UIKit

class LaunchViewController: UIViewController {
    private let imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        
        
        
        
    }
    override func viewDidLayoutSubviews() {
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.animate()
        })
        
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations:  {
            let size = self.view.frame.size.width * 3
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size)
        })
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }) { done in
            if done{
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                    let newViewControllers = [mainTabBarController]
                    if let navigationController = self.navigationController {
                        navigationController.setViewControllers(newViewControllers, animated: false)
                    }

                })
            }
        }
        
        
        
        
        
    }
    
}

