//
//  Cell.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 11.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import UIKit

class BaseCells: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        
    }
}



