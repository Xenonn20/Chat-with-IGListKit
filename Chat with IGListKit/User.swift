//
//  User.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 12.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class User: NSObject {
    
    let name: String!
    let image: UIImage!
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
