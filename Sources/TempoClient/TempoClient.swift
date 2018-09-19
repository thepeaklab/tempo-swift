//
//  Author.swift
//  TempoClient
//
//  Created by Robert Feldhus on 09.08.18.
//

import Foundation
import Quack


public class TempoClient: Quack.Client {

    private let dateFormatter = DateFormatter()
    private var authToken: String

    public static var dateFormatterStartDate: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }

    public static var dateFormatterStartTime: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "HH:mm:ss"
        return df
    }

    public init(authToken token: String) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.authToken = token
        super.init(url: URL(string: "https://api.tempo.io/2")!)
    }

}

// MARK: - Worklogs All

public extension TempoClient {

    public func getWorklogs(from: Date,
                            to: Date,
                            limit: Int = 50) -> Quack.Result<WorklogResult> {

        let headers = [
            "Authorization": "\(authToken)"
        ]

        let params = [
            "dateFrom": dateFormatter.string(from: from),
            "dateTo": dateFormatter.string(from: to),
            "limit": "\(limit)"
        ]

        let path = buildPath("/worklogs",
                             withParams: params)

        return respond(path: path,
                       headers: headers,
                       model: WorklogResult.self)
    }

    public func getWorklogs(from: Date,
                            to: Date,
                            limit: Int = 50,
                            completion: @escaping (Quack.Result<WorklogResult>) -> (Void)) {

        let headers = [
            "Authorization": "\(authToken)"
        ]

        let params = [
            "dateFrom": dateFormatter.string(from: from),
            "dateTo": dateFormatter.string(from: to),
            "limit": "\(limit)"
        ]

        let path = buildPath("/worklogs",
                             withParams: params)

        return respondAsync(path: path,
                       headers: headers,
                       model: WorklogResult.self,
                       completion: completion)
    }

}

// MARK: - Worklog User

public extension TempoClient {

    public func getWorklogsForUser(user: String,
                                   from: Date,
                                   to: Date,
                                   limit: Int = 50) -> Quack.Result<WorklogResult> {
        let headers = [
            "Authorization": "\(authToken)"
        ]

        let params = [
            "dateFrom": dateFormatter.string(from: from),
            "dateTo": dateFormatter.string(from: to),
            "limit": "\(limit)"
        ]

        let path = buildPath("/worklogs/user/\(user)",
            withParams: params)

        return respond(path: path,
                       headers: headers,
                       model: WorklogResult.self)
    }

    public func getWorklogsForUser(user: String,
                                   from: Date,
                                   to: Date,
                                   limit: Int = 50,
                                   completion: @escaping (Quack.Result<WorklogResult>) -> (Void)) {
        let headers = [
            "Authorization": "\(authToken)"
        ]

        let params = [
            "dateFrom": dateFormatter.string(from: from),
            "dateTo": dateFormatter.string(from: to),
            "limit": "\(limit)"
        ]

        let path = buildPath("/worklogs/user/\(user)",
            withParams: params)

        return respondAsync(path: path,
                            headers: headers,
                            model: WorklogResult.self,
                            completion: completion)
    }


}

// MARK: - Create Worklog

public extension TempoClient {

    public func createWorklog(issueKey: String,
                              minutesSpend: Int,
                              billableMinutesSpend: Int,
                              startDate: Date,
                              startTime: Date?,
                              description: String,
                              authorUserName: String) -> Quack.Result<Worklog> {

        let headers = [
            "Authorization": "\(authToken)"
        ]

        let body = [
            "issueKey": issueKey,
            "timeSpentSeconds": minutesSpend*60,
            "billableSeconds": billableMinutesSpend*60,
            "startDate": TempoClient.dateFormatterStartDate.string(from: startDate),
            "startTime": TempoClient.dateFormatterStartTime.string(from: startTime ?? Date()),
            "description": description,
            "authorUsername": authorUserName
            ] as [String : Any]

        return respond(method: .post,
                       path: "/worklogs",
                       body: Quack.JSONBody(body),
                       headers: headers,
                       model: Worklog.self,
                       requestModification: { request in
                        var request = request
                        request.encoding = .json
                        return request
        })
    }

    public func createWorklog(issueKey: String,
                              minutesSpend: Int,
                              billableMinutesSpend: Int,
                              startDate: Date,
                              startTime: Date?,
                              description: String,
                              authorUserName: String,
                              completion: @escaping (Quack.Result<Worklog>) -> (Void)) {

        let headers = [
            "Authorization": "\(authToken)"
        ]

        let body = [
            "issueKey": issueKey,
            "timeSpentSeconds": minutesSpend*60,
            "billableSeconds": billableMinutesSpend*60,
            "startDate": TempoClient.dateFormatterStartDate.string(from: startDate),
            "startTime": TempoClient.dateFormatterStartTime.string(from: startTime ?? Date()),
            "description": description,
            "authorUsername": authorUserName
            ] as [String : Any]

        return respondAsync(method: .post,
                            path: "/worklogs",
                            body: Quack.JSONBody(body),
                            headers: headers,
                            model: Worklog.self,
                            requestModification: { request in
                                var request = request
                                request.encoding = .json
                                return request
                            },
                            completion: completion)
    }

}
