//
//  UIImageView+SDWebImage.swift

//  Created by Dhaval Trivedi on 11/04/21.
//


import UIKit
import SDWebImage

extension UIImageView {
    // Image download and cache using SDWebImage
    func setImageWith(url: URL, placeholder:UIImage?,imageIndicator:SDWebImageActivityIndicator, completion:((UIImage?, Error?) -> Void)?) {
        self.sd_imageIndicator = imageIndicator
        self.sd_setImage(with: url, placeholderImage: placeholder, options: .retryFailed, context: nil, progress: nil) { (img, error, cacheType, url) in
            if error != nil {
                if placeholder == nil {
                    self.image =  UIImage(named: "placeholder")
                } else {
                    self.image = placeholder
                }
            }
            if completion != nil {
                completion!(img, error)
            }
        }
    }
    
}
