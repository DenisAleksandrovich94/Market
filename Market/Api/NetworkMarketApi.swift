import UIKit

class NetworkMarketApi {
    
    static let shared = NetworkMarketApi()
    
    private init(){}
    
    
    private let urlString = "https://dummyjson.com/carts"
    
    
    func fetchCarts(products count: Int, completion: @escaping (Result <[ProductsApi.Products], Error>) -> ()) {
        
        guard let url = URL(string:urlString) else {
            print("Error url")
            return}
        URLSession.shared.dataTask(with: url){data ,response, error in
         
            guard let data else {
                print("Error responce")
                return }
            
            do{
                let products = try JSONDecoder().decode(ProductsApi.self, from: data)
                
                var allProducts = [ProductsApi.Products]()

                products.carts.forEach { cart in
                    cart.products.forEach { product in
                        allProducts.append(product)
                    }
                }
        
                let prefix = Array(allProducts.prefix(count))
       
                completion(.success(prefix))
                
            } catch {
                print("decoder error catch")
            }
  
        }.resume()
        
        
        
    }
    
    
}
