import UIKit

class NetWorkApi {
    
    static let shared = NetWorkApi()
    
    private init(){}
    
    
    private let urlString = "https://dummyjson.com/carts"
    
    
    func fetchCarts(products count: Int, completion: @escaping (Result <[MarketApi.Products], Error>) -> ()) {
        
        guard let url = URL(string:urlString) else {
            print("Error url")
            return}
        URLSession.shared.dataTask(with: url){data ,response, error in
         
            guard let data else {
                print("Error responce")
                return }
            
            do{
                let products = try JSONDecoder().decode(MarketApi.self, from: data)
                
                var allProducts = [MarketApi.Products]()

                products.carts.forEach { cart in
                    cart.products.forEach { product in
                        allProducts.append(product)
                    }
                }
                
                //var resultProducts = [MarketApi.Products]()
                
                let prefix = Array(allProducts.prefix(count))
                
//                for product in 0..<count {
//                    resultProducts.append(allProducts[product])
//                }
                completion(.success(prefix))
                
            } catch {
                print("decoder error catch")
            }
  
        }.resume()
        
        
        
    }
    
    
}
