//
//  main.swift
//  PerfectArcade
//
//  Created by Jonathan Guthrie 2016-10-12.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

import PerfectRequestLogger
import SQLiteStORM

// Adding the location for the log file
RequestLogFile.location = "./webLog.log"

// Creating the connection to the SQLite3 database
SQLiteConnector.db = "./scoresdb"
let scores = Score()
// Creating the table if it does not yet exist
try? scores.setup()



// Create HTTP server.
let server = HTTPServer()

// Setup logging
let logger = RequestLogger()
// Set the log marker for the timer when the request is incoming
server.setRequestFilters([(logger, .high)])
// Finish the log trracking when the request is complete and ready to be returned to client
server.setResponseFilters([(logger, .low)])


// Register routes and handlers
let JSONRoutes = makeJSONRoutes("/api/v1")

// Add the routes to the server.
server.addRoutes(JSONRoutes)





// Set a listen port of 8181
server.serverPort = 8181

// Set a document root.
// This is optional. If you do not want to serve static content then do not set this.
// Setting the document root will automatically add a static file handler for the route /**
server.documentRoot = "./webroot"

// Gather command line options and further configure the server.
// Run the server with --help to see the list of supported arguments.
// Command line arguments will supplant any of the values set above.
configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
