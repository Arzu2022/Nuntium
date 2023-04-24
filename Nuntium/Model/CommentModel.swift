//
//  CommentModel.swift
//  Nuntium
//
//  Created by AziK's  MAC on 23.04.23.
//

import Foundation
import UIKit
public struct CommentModel: Codable {
    let imageData:Data
    let name:String
    let comment:String
    
    var image: UIImage? {
           guard let image = UIImage(data: imageData) else {
               return nil
           }
           return image
       }
       
       init(image: UIImage, name: String, comment: String) {
           self.imageData = image.jpegData(compressionQuality: 1.0)!
           self.name = name
           self.comment = comment
       }
}
