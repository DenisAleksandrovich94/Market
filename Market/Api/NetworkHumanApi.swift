import UIKit
import RealmSwift

class NetworkHumanApi {
    
    static let shared = NetworkHumanApi()
    
    private init () {}
    
    private let urlString = "https://dummyjson.com/users/1"
    
    func fetchHuman(completion: @escaping (Result<User, Error>)->()) {
        
        guard let url = URL(string: urlString) else {
            print("Url error")
            return }
        
        URLSession.shared.dataTask(with: url){data,_,_ in
            
            guard let data else {
                print("decoding data error")
                return}
            
            do {
                let userDecoder = try JSONDecoder().decode(User.self, from: data)

                completion(.success(userDecoder))
            } catch {
                
            }
      
        }.resume()
        
    }
    
    
}
