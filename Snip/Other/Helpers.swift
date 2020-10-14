//
//  Helpers.swift
//  Snip
//
//  Created by Kirill Beletskiy on 14/10/2020.
//  Copyright © 2020 kirqe. All rights reserved.
//

import Foundation
import Cocoa

func NKPlaceholderImage(image:NSImage?, imageView:NSImageView?, imgUrl:String, compate:@escaping (NSImage?) -> Void){
    
    if image != nil && imageView != nil {
        imageView!.image = image!
    }
    
    var urlcatch = imgUrl.replacingOccurrences(of: "/", with: "#")
    let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    urlcatch = documentpath + "/" + "\(urlcatch)"
    
    let image = NSImage(contentsOfFile:urlcatch)
    if image != nil && imageView != nil
    {
        imageView!.image = image!
        compate(image)
        
    }else{
        
        if let url = URL(string: imgUrl){
            
            DispatchQueue.global(qos: .background).async {
                () -> Void in
                let imgdata = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    () -> Void in
                    imgdata?.write(toFile: urlcatch, atomically: true)
                    let image = NSImage(contentsOfFile:urlcatch)
                    compate(image)
                    if image != nil  {
                        if imageView != nil  {
                            imageView!.image = image!
                        }
                    }
                }
            }
        }
    }
}




func showPlaceholder(_ view: NSView) {
    let eV = EmptyViewController().view
    eV.autoresizingMask = [.width, .height]
    view.addSubview(eV)
}

