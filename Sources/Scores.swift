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

class Score: SQLiteStORM {
	var id = 0
	var user = ""
	var score = 0

	override open func table() -> String {
		return "score"
	}

	override func to(_ this: StORMRow) {
		id      = this.data["id"] as? Int ?? 0
		user	= this.data["user"] as! String
		score	= this.data["score"] as! Int
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

	public func setup() {
		do {
			try sqlExec("CREATE TABLE IF NOT EXISTS score (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user TEXT, score INT)")
		} catch {
			print(error)
		}
	}
}
