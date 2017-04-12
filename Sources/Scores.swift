//
//  Scores.swift
//  PerfectArcade
//
//  Created by Jonathan Guthrie on 2016-10-13.
//
//

import StORM
import SQLiteStORM
import PerfectLib

// Score class
// Inherits all ORM methods from SQLiteStORM superclass
class Score: SQLiteStORM {
	var id = 0
	var user = ""
	var score = 0

	// Set the table name
	override open func table() -> String {
		return "score"
	}

	// Need to do this because of the nature of Swift's introspection
	override func to(_ this: StORMRow) {
		id      = this.data["id"] as? Int ?? 0
		user	= this.data["user"] as? String ?? ""
		score	= this.data["score"] as? Int ?? 0
	}

	func rows() -> [Score] {
		var rows = [Score]()
		for i in 0..<self.results.rows.count {
			let row = Score()
			row.to(self.results.rows[i])
			rows.append(row)
		}
		return rows
	}

}
