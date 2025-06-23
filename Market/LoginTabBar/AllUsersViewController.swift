//

import UIKit
import RealmSwift

class AllUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    
    var users: [Human]!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllUsersTableViewCell", for: indexPath) as! AllUsersTableViewCell
       
        cell.targetButton(completion: {[weak self] in
            guard let self else { return }
            let vc = tabBarController?.viewControllers?.first as! ProfileViewController
            vc.user = users[indexPath.row]
        })
        cell.nameUser.text = users[indexPath.row].name
   
        guard !users[indexPath.row].image.isEmpty  else {
            cell.imageUser.image = UIImage(named: "user")
            return cell }
           
             cell.imageUser.image = UIImage(data: users[indexPath.row].image)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        downloadUsersFromRealm()
    }
    
    func downloadUsersFromRealm() {
        let realm = try! Realm()
        users = Array(realm.objects(Human.self))
        tableView.reloadData()
    }
    
}
