//
//  Product.swift
//  Snip
//
//  Created by Kirill Beletskiy on 08/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation

// MARK: ProductsPage Response

struct ProductsPage: Decodable {
    var href: String?
    var total: Int?
    var next: String?
    var limit: Int?
    var offset: Int?
    var itemSummaries: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case href
        case total
        case next
        case limit
        case offset
        case itemSummaries
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.href = try? container.decode(String.self, forKey: .href)
        self.total = try? container.decode(Int.self, forKey: .total)
        self.next = try? container.decode(String.self, forKey: .next)
        self.limit = try? container.decode(Int.self, forKey: .limit)
        self.offset = try? container.decode(Int.self, forKey: .offset)
        self.itemSummaries = try? container.decode([Product].self, forKey: .itemSummaries)
    }
}

// MARK: Product

struct Product: Decodable {
    var itemId: String?
    var title: String?
    var condition: String?
    var image: Image?
    var price: Price?
    var seller: Seller?
    var itemLocation: ItemLocation?
    
    enum CodingKeys: String, CodingKey {
        case itemId
        case title
        case condition
        case image
        case price
        case seller
        case itemLocation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.itemId = try? container.decode(String.self, forKey: .itemId)
        self.title = try? container.decode(String.self, forKey: .title)
        self.condition = try? container.decode(String.self, forKey: .condition)
        self.image = try? container.decode(Image.self, forKey: .image)
        self.price = try? container.decode(Price.self, forKey: .price)
        self.seller = try? container.decode(Seller.self, forKey: .seller)
        self.itemLocation = try? container.decode(ItemLocation.self, forKey: .itemLocation)
    }
}

// MARK: ProductImage

struct Image: Decodable {
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try? container.decode(String.self, forKey: .imageUrl)
    }
}

// MARK: ProductPrice

struct Price: Decodable {
    var value: String?
    var currency: String?

    enum CodingKeys: String, CodingKey {
        case value
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try? container.decode(String.self, forKey: .value)
        self.currency = try? container.decode(String.self, forKey: .currency)
    }
}

// MARK: ProductSeller

struct Seller: Decodable {
    var username: String?
    var feedbackPercentage: String?
    var feedbackScore: Int?
    
    enum CodingKeys: String, CodingKey {
        case username
        case feedbackPercentage
        case feedbackScore
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try? container.decode(String.self, forKey: .username)
        self.feedbackPercentage = try? container.decode(String.self, forKey: .feedbackPercentage)
        self.feedbackScore = try? container.decode(Int.self, forKey: .feedbackScore)
    }
}

// MARK: ProductLocation

struct ItemLocation: Decodable {
    var postalCode: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
       case postalCode
       case country
    }
   
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.postalCode = try? container.decode(String.self, forKey: .postalCode)
       self.country = try? container.decode(String.self, forKey: .country)
    }
}




