//
//  Product.swift
//  22_04_24_WsebservicesNestedJSONWIthDecoderDemo
//
//  Created by Vishal Jagtap on 18/03/24.
//

import Foundation
struct Product : Decodable{
    var productId : Int
    var productName : String
    var price : Double
    var description : String
    var rate : Double
    var count : Int
    
    enum ProductKeys : String, CodingKey{
        case productId = "id"
        case productName = "title"
        case price
        case description
        case rating
    }
    
    enum RatingKeys : CodingKey{
        case rate
        case count
    }
    
    init(from decoder: Decoder) throws {
        let mainContainerOfProduct = try! decoder.container(keyedBy: ProductKeys.self)
        
        self.productId = try! mainContainerOfProduct.decode(Int.self, forKey: .productId)
        self.productName = try! mainContainerOfProduct.decode(String.self, forKey: .productName)
        self.description = try! mainContainerOfProduct.decode(String.self, forKey: .description)
        self.price = try! mainContainerOfProduct.decode(Double.self, forKey: .price)
        
        let ratingNestedContainer = try! mainContainerOfProduct.nestedContainer(keyedBy: RatingKeys.self, forKey: .rating)
        
        self.rate = try! ratingNestedContainer.decode(Double.self, forKey: .rate)
        self.count = try! ratingNestedContainer.decode(Int.self, forKey: .count)
    }
}
