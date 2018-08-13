//
//  Author.swift
//  TempoClient
//
//  Created by Robert Feldhus on 09.08.18.
//

import XCTest
@testable import TempoClient


class TempoClientTests: XCTestCase {

    // Auth

    private func tempoAuth() -> String {
        guard let authToken = ProcessInfo.processInfo.environment["authToken"]
        else {
            fatalError()
        }

        return authToken
    }

    // Worklogs for All Users

    func testGetWorklogsFromToday() {
        let client = TempoClient(authToken: tempoAuth())
        let result = client.getWorklogs(from: Date(), to: Date())

        switch result {
        case .success(let result):
            XCTAssertEqual(result.worklogs.count, 10)
        case .failure:
            XCTFail()
        }
    }

    // Worklogs for a specific User

    func testGetWorklogsForUser() {
        let client = TempoClient(authToken: tempoAuth())
        let result = client.getWorklogsForUser(user: "USERNAME", from: Date(), to: Date())

        switch result {
        case .success(let result):
            XCTAssertNotNil(result.worklogs.count)
        case .failure:
            XCTFail()
        }

    }

    // Create a Worklog

    func testCreateWorklog() {
        let client = TempoClient(authToken: tempoAuth())
        let result = client.createWorklog(issueKey: "ISSUEKEY",
                                          minutesSpend: 30,
                                          billableMinutesSpend: 30,
                                          startDate: Date(),
                                          startTime: Date(timeIntervalSinceNow: TimeInterval(-3600)),
                                          description: "Description",
                                          authorUserName: "USERNAME")

        switch result {
        case .success(let result):
            XCTAssertNotNil(result)
        case .failure:
            XCTFail()
        }
    }


}
