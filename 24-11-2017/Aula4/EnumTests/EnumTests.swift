//
//  EnumTests.swift
//  EnumTests
//
//  Created by Aloc SP08608 on 24/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import XCTest

enum Color : String {
    case Red = "RED"
    case Blue = "BLUE"
    case Green = "GREEN"
    case Yellow = "YELLOW"
    case Unknow = "UNKNOW"
    
    var description : String {
        switch self {
        case .Red:
            return "Vermelho"
        case .Blue:
            return "Azul"
        case .Green:
            return "Verde"
        case .Yellow:
            return "Amarelo"
        default:
            return "Preto"
        }
    }
}

enum Response {
    case Success([String : Any])
    case Failure(String)
}

class EnumTests: XCTestCase {

    func testColor() {
        
        XCTAssertNotEqual(Color.Blue.description, Color.Blue.rawValue)
        
    }
    
    func testEnum() {
        let ok = Response.Success(["200" : "{ code : 200 }"])
        let nok = Response.Failure("Page not found")
        let xok = Response.Failure("")

        verifyStatus(status: ok)
        verifyStatus(status: nok)
        verifyStatus(status: xok)
    }
    
    func verifyStatus(status : Response) {
        switch status {
        case .Success (let dict) :
            XCTAssertNotNil(dict)
        case .Failure(let resp) where resp.isEmpty :
            print("Ocorreu uma falha")
        case .Failure(let resp) :
            print(resp)
        }
    }

}
