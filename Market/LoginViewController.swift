//
//  ViewController.swift
//  Table of instructions
//
//  Created by Ivakhnenko Denis on 11.06.2025.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {
    
    
    @IBOutlet var loginTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var enterButton: UIButton!
    
    @IBOutlet var registrationButton: UIButton!
    
    @IBOutlet var openTheStore: UIButton!
    
    
    
    var user = Human(){
        didSet {
            loginTextField.text = user.username
            passwordTextField.text = user.password
        }
    }
    
    private var users: [Human]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTargetButtons()
    }
    
    
    private func AddTargetButtons() {
        enterButton.addTarget(self, action: #selector(openProfileVC), for: .touchUpInside)
        
        registrationButton.addTarget(self, action: #selector(openRegistrationVC), for: .touchUpInside)
        
        openTheStore.addTarget(self, action: #selector(openTheShop), for: .touchUpInside)
    }
    
    @objc private func openTheShop() {
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyBord.instantiateViewController(withIdentifier: "MainTabBar1") as! UITabBarController
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    @objc private func openRegistrationVC() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = storybord.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
        
    }
    
    @objc private func openProfileVC() {
           
        if let user = checkLoginAndPassword(login: loginTextField.text!, password: passwordTextField.text!)
        {
            CurrentUserHolder.shared.user = user
        
            
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
    
  
    
    private func checkLoginAndPassword(login: String, password: String) -> Human? {
       
        let realm = try! Realm()
        users = Array(realm.objects(Human.self))
        
        return  users.first { human in
            human.username == loginTextField.text &&
            human.password == passwordTextField.text
        }
    }
    
}

