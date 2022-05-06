//
//  SplashViewController.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 5.05.2022.
//

import Foundation
import UIKit

class SplashViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let destination = MovieListViewController()
        push(to: destination)
    }
    
    
   
}
