//
//  IndexHandler.swift
//  PerfectPress
//
//  Created by Ryan Collins on 6/9/16.
//  Copyright (C) 2016 Ryan M. Collins.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the PerfectPress open source blog project
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import SQLite

struct IndexHandler: MustachePageHandler {
    
    func extendValuesForResponse(context contxt: MustacheEvaluationContext, collector: MustacheEvaluationOutputCollector) {

        let DB_PATH = "./db/sitedb"

        do {
            let sqlite = try SQLite(DB_PATH)
        } catch {
            print("Database Failed")
        }

        var values = MustacheEvaluationContext.MapType()
        
        values["title"] = "Site Homepage"
        values["content"] = "Test Content! Lorem Ipsum Dolor Sit Amet!"

        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.setStatus(code: 500, message: "Server Error")
            response.appendBody(string: "\(error)")
            response.requestCompleted()
        }
    }
}