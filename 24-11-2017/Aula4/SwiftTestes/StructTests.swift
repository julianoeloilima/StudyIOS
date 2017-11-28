//
//  SwiftTestes.swift
//  SwiftTestes
//
//  Created by Aloc SP08608 on 24/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

typealias MovieS = Movie

struct Movie {
    let directory : String
    let title : String
    
    init() {
        directory = "Unknow directory"
        title = "Unknow title"
    }

    init(directory : String, title : String) {
        self.directory = directory
        self.title = title
    }

    init ? (dictionary : [String : String]) {
        directory = dictionary["directory"] ?? "Unknow directory"
        title = dictionary["title"] ?? "Unknow title"
    }
}

class MovieC {
    
    let directory : String
    let title : String
    
    init(directory : String, title : String) {
        self.directory = directory
        self.title = title
    }
    
    init?(dictionary : [String : String]) {
        self.directory = dictionary["directory"] ?? "Unknow directory"
        self.title = dictionary["title"] ?? "Unknow title"
    }

}

class StructTests: XCTestCase {
    
    func testStruct() {
        let movie = Movie(directory: "Dali", title: "Cangaceiro")
        XCTAssertEqual(movie.title, "Cangaceiro")
        
        guard Movie(dictionary : ["title" : "Lagoa Azul", "directory" : "Edigar"]) != nil else {
            XCTFail("Falha ao criar Movie")
            return
        }
        
    }
    
    func testStructVsClass() {
        var ms = MovieS(directory: "DirMovieS", title: "TitleMovieS")
        var mc = MovieC(directory: "DirMovieC", title: "TitleMovieC")
        
        print("MStruc \(ms.title)")
        print("MClass \(mc.title)")
        
        func teste(item : Any) -> String? {
            if item is MovieC {
                let mmc : MovieC = item as! MovieC
                return "MovieC - title: \(mmc.title)"
            }
            else if item is MovieS {
                let mms : MovieS = item as! MovieS
                return "MovieC - title: \(mms.title)"
            }
            return nil
        }
        
        print(teste(item: ms))
        print(teste(item: mc))
    }
    
    
    
}
