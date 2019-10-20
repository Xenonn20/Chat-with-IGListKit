//
//  ChatCell.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 12.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class ChatCell: BaseCells {
    
    static let reuseID = "ChatCell"
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsets(top: 22, left: 26, bottom: 22, right: 26)).withRenderingMode(.alwaysTemplate)
    
    var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.text = "Message"
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var textBubbleView: UIView = {
           let view = UIView()
           view.layer.cornerRadius = 15
           view.layer.masksToBounds = true
           return view
       }()
    
    var profileImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.layer.cornerRadius = 15
           imageView.image = #imageLiteral(resourceName: "man")
           imageView.layer.masksToBounds = true
           return imageView
       }()
    
    var bubbleImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.image = ChatCell.blueBubbleImage
         imageView.tintColor = UIColor(white: 0.90, alpha: 1)
         return imageView
     }()
     
     var nameLabel: UILabel = {
         
         let lbl = UILabel()
         lbl.textAlignment = .right
         lbl.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
         lbl.font = UIFont.boldSystemFont(ofSize: 15)
         return lbl
     }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textBubbleView)
        addSubview(nameLabel)
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        profileImageView.backgroundColor = UIColor.green
        
        textBubbleView.addSubview(bubbleImageView)
        
        addConstraintsWithVisualStrings(format: "H:|[v0]|", views: bubbleImageView)
        addConstraintsWithVisualStrings(format: "V:|[v0]|", views: bubbleImageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.profileImageView.image = nil
        self.messageTextView.text = nil
    }
    
    
}
