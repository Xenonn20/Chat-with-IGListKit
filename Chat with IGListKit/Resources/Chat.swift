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
    
    func loadChat() -> [Message] {
        let userOne = User(name: "Алексей", image: #imageLiteral(resourceName: "alexey"))
        
        let chat = [
            Message(user: userOne,sendByMe: false, messgae: "Привет, Кирилл! Это Алексей из компании Геометр."),
            Message(user: userOne,sendByMe: false, messgae: "Я слышал, ты ищешь работу. Нам как раз нужны такие ребята.")
        ]
        self.chat = chat
        return chat
    }
}
