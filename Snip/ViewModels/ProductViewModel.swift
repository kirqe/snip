//
//  ProductViewModel.swift
//  Snip
//
//  Created by Kirill Beletskiy on 14/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation
import Cocoa

class ProductViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    public var title: String {
        return product.title ?? "n/a"
    }
    
    public var imageUrl: String {
        return product.image?.imageUrl ?? "n/a"
    }
    
    public var condition: String {
        return product.condition ?? "n/a"
    }

    public var priceString: String {
        let value = product.price?.value ?? "n/a"
        let currency = product.price?.currency ?? "n/a"
        
        return "\(value) \(currency)"
    }
    
    public var locationString: String {
        let country = product.itemLocation?.country ?? "n/a"
        let postalCode = product.itemLocation?.postalCode ?? "n/a"
        
        return "\(country) \(postalCode)"
    }
    
    public var sellerString: String {
        let username = product.seller?.username ?? "n/a"
        let feedbackScore = String(describing: product.seller!.feedbackScore!)
        let feedbackPercentage = product.seller?.feedbackPercentage ?? "n/a"
        
        return "\(username) (\(feedbackScore)) ★) \(feedbackPercentage) %"
    }
    
    public var conditionString: String {
        let condition = product.condition ?? "n/a"
        
        return condition
    }
}


extension ProductViewModel {
    func configure(_ view: ProductCollectionViewItem) {
        view.productTitle.stringValue = title
        view.productPrice.stringValue = priceString
        view.productLocation.stringValue = locationString
        view.productSeller.stringValue = sellerString
        view.productCondition.stringValue = conditionString
        
        NKPlaceholderImage(image: NSImage(named: "placeholderImage"), imageView: view.productImage, imgUrl: imageUrl) { (image) in }
        
        if let productConditionLabel = view.productCondition {
            switch condition {
            case "New":
                productConditionLabel.textColor = NSColor.red
                productConditionLabel.font = NSFont(name: "System Heavy Regular", size: 13)
            case "Open box":
                productConditionLabel.textColor = NSColor.init(deviceRed: 34/255, green: 172/255, blue: 59/255, alpha: 1.0)
            case "Seller Refurbished":
                productConditionLabel.textColor = NSColor.gray
            default:
                productConditionLabel.textColor = NSColor.black
            }
        }
    }
    

}
