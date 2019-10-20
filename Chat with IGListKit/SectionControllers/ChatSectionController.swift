//
//  ChatSectionController.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 13.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit
import IGListKit

class ChatSectionController: ListSectionController {
    
    var message: Message!
    let chatVC = ChatViewController()
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func didUpdate(to object: Any) {
        message = object as? Message
    }
    
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        guard let context = collectionContext, let message = message else { return .zero }
        
        
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: message.message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        let width = context.containerSize.width
        
        return CGSize(width: width, height: estimatedFrame.height + 20)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        

        
        if let cell = collectionContext!.dequeueReusableCell(of: ChatCell.self, for: self, at: index) as? ChatCell {
       
                
        
                    cell.messageTextView.text = message.message
                    cell.nameLabel.text = message.user.name
                    cell.profileImageView.image = message.user.image
        
        
                    let size = CGSize(width: 250, height: 1000)
                    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                    var estimatedFrame = NSString(string: message.message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
                    estimatedFrame.size.height += 18
        
                    let nameSize = NSString(string: message.user.name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
        
                    let maxValue = max(estimatedFrame.width, nameSize.width)
                    estimatedFrame.size.width = maxValue
            
        
        
                    if message.sendByMe {
                        guard let context = collectionContext else { return cell}
                        
                        cell.nameLabel.textAlignment = .right
                        cell.profileImageView.frame = CGRect(x: context.containerSize.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
                        cell.nameLabel.frame = CGRect(x: context.containerSize.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
                        cell.messageTextView.frame = CGRect(x: context.containerSize.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                        cell.textBubbleView.frame = CGRect(x: context.containerSize.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
                        cell.bubbleImageView.image = ChatCell.blueBubbleImage
                        cell.bubbleImageView.tintColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                        cell.messageTextView.textColor = UIColor.white
        
                    } else {
                        cell.nameLabel.textAlignment = .left
                        cell.profileImageView.frame = CGRect(x: 8, y: estimatedFrame.height - 8, width: 30, height: 30)
                        cell.nameLabel.frame = CGRect(x: 48 + 8, y: 0, width: estimatedFrame.width + 16, height: 18)
                        cell.messageTextView.frame = CGRect(x: 48 + 8, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                        cell.textBubbleView.frame = CGRect(x: 48 - 10, y: -4, width: estimatedFrame.width + 16 + 8 + 16 + 12, height: estimatedFrame.height + 20 + 6)
                        cell.bubbleImageView.image = ChatCell.grayBubbleImage
                        cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                        cell.messageTextView.textColor = UIColor.black
                    }
        
                    return cell
                }
        
                return ChatCell()
        
       
    }
    
}
