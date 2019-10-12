//
//  ChatViewController.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 12.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    let chat = Chat()
    
    private var chatArray: [Message] = []
    
    @IBOutlet weak var chatCollectionView: UICollectionView!
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = chat.loadChat()
        chatArray = chat.chat
        assignDelegates()
        manageInputEventsForTheSubViews()
    }
    
    // Setup delegates and register Cell
    private func assignDelegates() {
        
        self.chatCollectionView.dataSource = self
        self.chatCollectionView.delegate = self
        self.chatTextField.delegate = self
        self.chatCollectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.reuseID)
        
    }
    // MARK: - IBAction sendButton
    @IBAction func sendButtonTapped(_ sender: UIButton?) {
        guard let chatText = chatTextField.text , chatText.count >= 1 else { return }
        chatTextField.text = ""
        let user = User(name: "Кирилл", image: #imageLiteral(resourceName: "kirill"))
        let message = Message(user: user, sendByMe: true, messgae: chatText)
        
        self.chatArray.append(message)
        self.chatCollectionView.reloadData()
        
        let lastItem = self.chatArray.count - 1
        let indexPath = IndexPath(item: lastItem, section: 0)
        self.chatCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    // MARK: - Change height of textfield and sendButton
    private func manageInputEventsForTheSubViews() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChangeNotfHandler(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardFrameChangeNotfHandler(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let lastItem = self.chatArray.count - 1
                    let indexPath = IndexPath(item: lastItem, section: 0)
                    self.chatCollectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            })
        }
    }
}

// MARK: - CollectionViewDataSource, CollectionViewDelegate

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = chatCollectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.reuseID, for: indexPath) as? ChatCell {
            
            let chat = chatArray[indexPath.item]
            
            cell.messageTextView.text = chat.message
            cell.nameLabel.text = chat.user.name
            cell.profileImageView.image = chat.user.image
        
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            var estimatedFrame = NSString(string: chat.message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            estimatedFrame.size.height += 18
            
            let nameSize = NSString(string: chat.user.name).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)], context: nil)
            
            let maxValue = max(estimatedFrame.width, nameSize.width)
            estimatedFrame.size.width = maxValue
            
            
            if chat.sendByMe {
                cell.nameLabel.textAlignment = .right
                cell.profileImageView.frame = CGRect(x: self.chatCollectionView.bounds.width - 38, y: estimatedFrame.height - 8, width: 30, height: 30)
                cell.nameLabel.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30 - 12, y: 0, width: estimatedFrame.width + 16, height: 18)
                cell.messageTextView.frame = CGRect(x: collectionView.bounds.width - estimatedFrame.width - 16 - 16 - 8 - 30, y: 12, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.textBubbleView.frame = CGRect(x: collectionView.frame.width - estimatedFrame.width - 16 - 8 - 16 - 10 - 30, y: -4, width: estimatedFrame.width + 16 + 8 + 10, height: estimatedFrame.height + 20 + 6)
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let chat = chatArray[indexPath.item]
        if let chatCell = cell as? ChatCell {
            chatCell.profileImageView.image = chat.user.image
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let chat = chatArray[indexPath.item]
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        var estimatedFrame = NSString(string: chat.message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        estimatedFrame.size.height += 18
        
        return CGSize(width: chatCollectionView.frame.width, height: estimatedFrame.height + 20)
    }
}


// MARK - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let txt = textField.text, txt.count >= 1 {
            return true
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        sendButtonTapped(nil)
    }

}
