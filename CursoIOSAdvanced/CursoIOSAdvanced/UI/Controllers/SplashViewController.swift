//
//  SplashViewController.swift
//  CursoIOSAdvanced
//
//  Created by David Jardon on 02/10/2019.
//  Copyright © 2019 David Jardon. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let viewControllerDestination = storyboard.instantiateInitialViewController() else {
                return
            }
            
            self.present(viewControllerDestination, animated: true)
        }
    }


}

