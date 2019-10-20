//
//  Chat.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 12.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class Chat {
    
    var chat: [Message] = []
    
    func loadChat() {
        let userOne = User(name: "Alex", image: #imageLiteral(resourceName: "man"))
        let userTwo = User(name: "Max", image: #imageLiteral(resourceName: "kirill"))
        
        let chat = [
            Message(user: userOne,sendByMe: false, messgae: "Hi, Max! How are you?"),
            Message(user: userOne,sendByMe: false, messgae: "I heard you are looking for work. We need guys like you."), Message(user: userOne,sendByMe: false, messgae: "Need to make a cool application."), Message(user: userTwo,sendByMe: true, messgae: "Hi, Alex!"), Message(user: userTwo,sendByMe: true, messgae: "Ready to complete this task.")
        ]
        self.chat = chat
    
    }
}
