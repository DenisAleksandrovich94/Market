

import UIKit
import RealmSwift


class RegistrationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var userNameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var addImageButton: UIButton!
    
    @IBOutlet var saveUserButton: UIButton!
    
    
    @IBOutlet var stack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installRightBarButton()
        addImageButton.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        saveUserButton.addTarget(self, action: #selector(saveDataUser), for: .touchUpInside)
        
        
    }
    
    @objc private func saveDataUser() {
        
        let realm = try! Realm()
        
        guard
            !nameTextField.text!.isEmpty,
            !userNameTextField.text!.isEmpty,
            !passwordTextField.text!.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "There is no all data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        
        let human = realm.objects(Human.self).contains(where: { human in
            human.username == userNameTextField.text!
        })
        
        if human {
            let alert = UIAlertController(title: "Error", message: "Nickname is already taken", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
            
        } else {
            let user = Human()
 
            user.name = nameTextField.text!
            user.username = userNameTextField.text!
            user.password = passwordTextField.text!
            user.cardExpire = generateCard().cardExpire
            user.cardNumber = generateCard().cardNumber
            user.id = UUID()
            
            if imageView.image != nil,
               let imageSmall = imageView.image?.jpegData(compressionQuality: 0.6)
            {
                user.image = imageSmall
            }
            
            try! realm.write {
                realm.add(user)
            }
            
            let loginController = navigationController?.viewControllers.first as! LoginViewController
            loginController.user = user
            
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    private func generateCard() -> (cardNumber: String, cardExpire: String) {
        
        var cardNumber = ""
        for number in 1...16 {
            let currentNumber = Int.random(in: 0...9)
            cardNumber.append("\(currentNumber)")
            
            if  number % 4 == 0, number != 16 {
                cardNumber.append("  ")
            }
        }
        let cardExpire = ("\(Int.random(in: 1...12))/\(Int.random(in: 24...40))")
        
        return (cardNumber, cardExpire)
    }
    
    @objc private func addImage() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        //imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true)
        //imagePickerController
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        imageView.image = info[.originalImage] as? UIImage
        picker.dismiss(animated: true)
    }
    
    private func installRightBarButton() {
        
        let menu = UIMenu(title:"Menu" , image: UIImage(systemName: "figure.stand"), children: [
            UIAction(title: "NewUser", image: UIImage(systemName: "person.fill.checkmark.rtl"), handler: {[weak self]  _ in
                guard let self else { return }
                stack.isHidden = false
                nameTextField.text = nil
                userNameTextField.text = nil
                passwordTextField.text = nil
                imageView.image = nil
                print("new")
            }),
            UIAction(title: "TestUser", image: UIImage(systemName: "person.fill.questionmark.rtl"), handler: {[weak self] _ in
                guard let self else { return }
                stack.isHidden = false
                
                NetworkHumanApi.shared.fetchHuman { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let user):
                        
                        var image: UIImage?
                        
                        if let url = URL(string:user.image), let imageData = try? Data(contentsOf:url) {
                            image = UIImage(data: imageData)
                        } else {
                            image = UIImage(named: "user")
                        }
                        
                        DispatchQueue.main.async{ [weak self] in
                            guard let self else { return }
                            installDataUser(user: user, image: image)
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                print("test")
            })
            
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            //title: "Menu",
            image: UIImage(systemName: "figure.stand"),
            menu: menu
        )
    }
    
    private func installDataUser(user: User, image: UIImage?){
        
        nameTextField.text = user.firstName + " " + user.lastName
        userNameTextField.text = user.username
        passwordTextField.text = user.password
        imageView.image = image
        
    }
}
