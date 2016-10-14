//
//  Routes.swift
//  PerfectArcade
//
//  Created by Jonathan Guthrie on 2016-10-13.
//
//

import PerfectHTTP
import SQLiteStORM
import StORM

public func makeJSONRoutes(_ root: String = "/api/v1") -> Routes {
	var routes = Routes()

	routes.add(method: .get, uri: "\(root)/save", handler: processSaveScore)
	routes.add(method: .get, uri: "\(root)/highscores", handler: getHighScores)


	return routes
}


func processSaveScore(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "application/json")
	var resp = [String: String]()

	let score = Score(connect)
	score.score = Int(request.param(name: "score")!)!
	score.user = request.param(name: "user")!

	do {
		try score.save()
		resp["error"] = "No Error"
	} catch {
		print(error)
		resp["error"] = String(describing: error)
	}

	do {
		try response.setBody(json: resp)
	} catch {
		print(error)
	}
	response.completed()
}

func getHighScores(request: HTTPRequest, _ response: HTTPResponse) {
	response.setHeader(.contentType, value: "application/json")
	var resp = [String: Any]()


	let score = Score(connect)
	let cursor = StORMCursor(limit: 10, offset: 0)

	do {
		try score.select(columns: ["user","score"], whereclause: "score > :1", params: [0], orderby: ["score DESC"], cursor: cursor)
		var resultArray = [[String: Any]]()

		for row in score.rows() {
			var r = [String: Any]()
			r["user"] = row.user
			r["score"] = row.score
			resultArray.append(r)
		}
		resp["highscores"] = resultArray
	} catch {
		print(error)
	}

	do {
		try response.setBody(json: resp)
	} catch {
		print(error)
	}
	response.completed()
}

