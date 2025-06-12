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
    
    @IBOutlet var testEnterButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterButton.addTarget(self, action: #selector(openNewVC), for: .touchUpInside)
        
        NetWorkApi.shared.fetchCarts(products: 10) { result in
            switch result {
            case .success (let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @objc private func openNewVC() {
        
        if loginTextField.text == "0000", passwordTextField.text == "0000" {
            let storybord = UIStoryboard(name: "Main", bundle: nil)
            let newVC = storybord.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            navigationController?.pushViewController(newVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка ввода данных", message: "Попробуйте ввести еще раз", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
            present(alert, animated: true)
            
        }
        
      
        
    }


}

