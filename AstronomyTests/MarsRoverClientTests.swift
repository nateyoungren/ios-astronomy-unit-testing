//
//  MarsRoverClientTests.swift
//  AstronomyTests
//
//  Created by Nathanael Youngren on 3/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import XCTest
@testable import Astronomy

struct MockLoader: NetworkDataLoader {
    
    var data: Data
    var error: Error
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(self.data, self.error)
        }
    }
}

class MarsRoverClientTests: XCTestCase {
    
    /*
     What to test?
     - fetchMarsRover
         - Test the data
         - Base URL and the constructed URL are correct?
         - Verify the dataTask is being completed
         - Test that it can decode with JSON?
         - Valid JSON
         - Invalid JSON
         - Is the completion handler being called if networking fails?
         - Is the completion handler being called if the data is bad?
         - Is the completion handler being called with valid data?
     - fetchPhotos
     - fetch Generic
     */
    
    
}
