//
//  Handlers.swift
//  PerfectArcade
//
//  Created by Jonathan Guthrie on 2016-10-15.
//
//

import PerfectHTTP
import SQLiteStORM
import StORM

// Handles the incoming score creation
func processSaveScore(request: HTTPRequest, _ response: HTTPResponse) {
	// Set the response type
	response.setHeader(.contentType, value: "application/json")
	// Container for response data
	var resp = [String: String]()

	// process incoming data, with protections in case the params are not supplied
	guard let theScore = Int(request.param(name: "score")!), let theUser = request.param(name: "user") else {
		// set an error response to be returned
		response.status = .badRequest
		resp["error"] = "Please supply values"
		do {
			try response.setBody(json: resp)
		} catch {
			print(error)
		}
		response.completed()
		return
	}

	// initialize the Score var
	let score = Score(connect)

	// now that the params have been confirmed to be there, set to the vars
	score.score = theScore
	score.user = theUser

	// save to db
	do {
		try score.save()
		resp["error"] = "No Error"
	} catch {
		print(error)
		resp["error"] = String(describing: error)
	}

	// return response
	do {
		try response.setBody(json: resp)
	} catch {
		print(error)
	}
	response.completed()
}




// Handles request for high scores data
func getHighScores(request: HTTPRequest, _ response: HTTPResponse) {

	// set the JSON content type
	response.setHeader(.contentType, value: "application/json")

	// response data container
	var resp = [String: Any]()

	// set up container object for results
	let score = Score(connect)
	// set the cursor (number of results to return, and offset from start)
	let cursor = StORMCursor(limit: 10, offset: 0)

	// Select clause to get the results
	// Note that this uses parametization to protect values and ensure correct data types
	do {
		try score.select(columns: ["user","score"], whereclause: "score > :1", params: [0], orderby: ["score DESC"], cursor: cursor)
		var resultArray = [[String: Any]]()

		// process incoming array of data
		for row in score.rows() {
			var r = [String: Any]()
			r["user"] = row.user
			r["score"] = row.score
			resultArray.append(r)
		}
		// set array of data to the highscores property
		resp["highscores"] = resultArray
	} catch {
		print(error)
	}

	// return JSON data to client
	do {
		try response.setBody(json: resp)
	} catch {
		print(error)
	}
	response.completed()
}

