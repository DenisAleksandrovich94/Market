//
//  ViewController.swift
//  Table of instructions
//
//  Created by Ivakhnenko Denis on 11.06.2025.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet var loginTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var enterButton: UIButton!
    
    @IBOutlet var registrationButton: UIButton!
    
    @IBOutlet var testEnterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddTargetButtons()
        
        NetworkMarketApi.shared.fetchCarts(products: 10) { result in
            switch result {
            case .success (let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func AddTargetButtons() {
        enterButton.addTarget(self, action: #selector(openProfileVC), for: .touchUpInside)
       
        registrationButton.addTarget(self, action: #selector(openRegistrationVC), for: .touchUpInside)

    }
    
    @objc private func openRegistrationVC() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = storybord.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
        //navigationItem.rightBarButtonItem.menu
    }
    
    @objc private func openProfileVC() {
        
        if loginTextField.text == "0000", passwordTextField.text == "0000" {
            let storybord = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = storybord.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
            let profileVc = storybord.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let settingsVc = storybord.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            
            profileVc.tabBarItem = UITabBarItem(title: "Personal", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
            settingsVc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
            tabBar.viewControllers?.append(profileVc)
            tabBar.viewControllers?.append(settingsVc)
            tabBar.viewControllers?.swapAt(0, 1)
            tabBar.selectedIndex = 0
            
            navigationController?.pushViewController(tabBar, animated: true)
            
        } else {
            
            let alert = UIAlertController(title: "Ошибка ввода данных", message: "Попробуйте ввести еще раз", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
            present(alert, animated: true)
        }
        
       
    }
    
    
    
}

