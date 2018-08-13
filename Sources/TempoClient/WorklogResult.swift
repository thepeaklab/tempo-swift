//
//  WorklogResult.swift
//  TempoClient
//
//  Created by Robert Feldhus on 13.08.18.
//

import Foundation
import Quack
import SwiftyJSON


public extension TempoClient {

    public class WorklogResult: Quack.Model {

        public let worklogs: [Worklog]

        public required init?(json: JSON) {
            guard let worklogs = json["results"].array?.compactMap({ Worklog(json: $0) }) else { return nil }
            self.worklogs = worklogs
        }
        
    }

}
