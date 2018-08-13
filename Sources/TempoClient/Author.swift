//
//  Author.swift
//  TempoClient
//
//  Created by Robert Feldhus on 09.08.18.
//

import Foundation
import Quack
import SwiftyJSON


public extension TempoClient {

    public class Author: Quack.Model {

        let key: String
        let displayName: String

        public required init?(json: JSON) {
            guard
                let key = json["username"].string,
                let displayName = json["displayName"].string
                else { return nil }

            self.key = key
            self.displayName = displayName
        }

    }

}


extension TempoClient.Author: Hashable {

    public var hashValue: Int {
        return key.hashValue ^ displayName.hashValue
    }

    public static func ==(lhs: TempoClient.Author, rhs: TempoClient.Author) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}
