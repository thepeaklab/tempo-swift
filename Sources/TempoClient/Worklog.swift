//
//  Worklog.swift
//  TempoClient
//
//  Created by Robert Feldhus on 09.08.18.
//

import Foundation
import Quack
import SwiftyJSON


public extension TempoClient {

    public class Worklog: Quack.Model {

        let tempoWorklogId: Int
        let jiraWorklogId: Int
        let timeSpentSeconds: Int
        let billableSeconds: Int
        let startDate: Date
        let startTime: Date
        let description: String
        let author: Author

        public required init?(json: JSON) {
            guard let tempoWorklogId = json["tempoWorklogId"].int,
                let jiraWorklogId = json["jiraWorklogId"].int,
                let timeSpentSeconds = json["timeSpentSeconds"].int,
                let billableSeconds = json["billableSeconds"].int,
                let startDateString = json["startDate"].string,
                let startDate = TempoClient.dateFormatterStartDate.date(from: startDateString),
                let startTimeString = json["startTime"].string,
                let startTime = TempoClient.dateFormatterStartTime.date(from: startTimeString),
                let description = json["description"].string,
                let author = Author(json: json["author"])
            else {
                return nil
            }

            self.tempoWorklogId = tempoWorklogId
            self.jiraWorklogId = jiraWorklogId
            self.timeSpentSeconds = timeSpentSeconds
            self.billableSeconds = billableSeconds
            self.startDate = startDate
            self.startTime = startTime
            self.description = description
            self.author = author
        }

    }

}
