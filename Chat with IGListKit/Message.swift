//
//  Message.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 12.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class Message {
    
    let user: User
    let sendByMe: Bool
    let message: String
    
    init(user: User, sendByMe: Bool, messgae: String) {
        self.user = user
        self.sendByMe = sendByMe
        self.message = messgae
    }
}
