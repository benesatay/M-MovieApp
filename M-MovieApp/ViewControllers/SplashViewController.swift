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
        self.checkInternetConnection()
    }
    
    private func checkInternetConnection() {
        NetworkManager.shared.checkInternetConnection {
            let destination = MovieListViewController()
            NetworkManager.shared.cancelMonitoring()
            self.push(to: destination)
        } onError: { error in
            NetworkManager.shared.cancelMonitoring()
            self.presentAlert(with: error)
        }
    }
}
