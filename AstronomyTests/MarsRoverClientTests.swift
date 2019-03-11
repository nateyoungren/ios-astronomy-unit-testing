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
    
    var data: Data?
    var error: Error?
    var request: URLRequest?
    var url: URL?
    
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
     - fetchPhotos
     - fetch Generic
     */
    
    func testFetchMarsRoverDataTaskIsCompleted() {
        mockFetch(dataSource: validRoverJSON)
    }
    
    func testFetchMarsRoverHandlesBadJsonData() {
        mockFetch(dataSource: invalidRoverJSON, shouldShowError: true)
    }
    
    func testFetchMarsRoverHandlesNoResultsInJsonData() {
        mockFetch(dataSource: noResultsRoverJSON, shouldShowError: true)
    }
    
    func testFetchPhotosDataTaskIsCompleted() {
        mockFetch(dataSource: validRoverJSON)
    
        let photosExpectation = expectation(description: "Photos request")
        
        let roverToFetch = rover?.solDescriptions[0]
        
        self.marsRover?.fetchPhotos(from: rover!, onSol: roverToFetch!.sol) { (_, error) in
            photosExpectation.fulfill()
//            XCTAssertNil(error)
        }
        wait(for: [photosExpectation], timeout: 2.0)
    }
    
    func testFetchPhotosHandlesBadJsonData() {
        
    }
    
    func testFetchPhotosHandlesNoResultsInJsonData() {
        
    }
    
    private func mockFetch(dataSource: Data, shouldShowError: Bool = false) {
        var mock = MockLoader()
        mock.data = dataSource
        self.marsRover = MarsRoverClient(networkLoader: mock)
        let roverExpection = expectation(description: "Rover Data Request")
        
        marsRover?.fetchMarsRover(named: "Curiosity") { (marsRover, error) in
            
            roverExpection.fulfill()
            if shouldShowError {
                XCTAssertNil(marsRover)
                XCTAssertNotNil(error)
            } else {
                XCTAssertNil(error)
                XCTAssertNotNil(marsRover)
            }
            self.rover = marsRover
        }
        wait(for: [roverExpection], timeout: 2.0)
    }
    
    private var rover: MarsRover?
    private var marsRover: MarsRoverClient?
}
