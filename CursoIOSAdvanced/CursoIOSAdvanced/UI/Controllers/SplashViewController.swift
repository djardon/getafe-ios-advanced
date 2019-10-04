//
//  SplashViewController.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 02/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit
import Lottie


class SplashViewController: UIViewController {

    @IBOutlet weak var mViewLoading: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playAnimation()
        navigate()
    }
    
    func playAnimation() {
        let animationView = AnimationView(name: "loading_animation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.frame = mViewLoading.bounds
        mViewLoading.addSubview(animationView)
        
        animationView.play()
    }


    private func navigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewControllerDestination = storyboard.instantiateInitialViewController() else {
                return
            }
            
            self.present(viewControllerDestination, animated: true)
        }
    }
}

