//
//  ListDiffable.swift
//  Chat with IGListKit
//
//  Created by Кирилл Медведев on 13.10.2019.
//  Copyright © 2019 Kirill Medvedev. All rights reserved.
//

import Foundation
import IGListKit

extension NSObject: ListDiffable {
    
  public func diffIdentifier() -> NSObjectProtocol {
    return self
  }

  public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    return isEqual(object)
  }
}
