//
//  SearchScreenViewModelTests.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-12-01.
//

import Foundation
import XCTest
import Combine
@testable import Clara_Mobile_Challenge

class SearchScreenViewModelTests: XCTestCase {
    private var cancellables = [AnyCancellable]()
    
    func test_initialState() {
        // Given
        let viewModel = SearchViewModel()
        
        // Then
        XCTAssertTrue(viewModel.query.isEmpty)
        XCTAssertTrue(viewModel.results.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_initialSearchHandlesError() {
        // Arrange
        let mockLoader = MockDiscogsSearchLoader()
        mockLoader.error = URLError(.notConnectedToInternet)
        let viewModel = SearchViewModel()
        viewModel.discogsLoader = mockLoader
        
        // Act
        viewModel.query = "Test"
        
        let expectation = expectation(description: "wait for searchFinishedPublisher")
        
        viewModel
            .searchFinishedPublisher
            .first()
            .sink {
                XCTAssertEqual(viewModel.errorMessage, URLError(.notConnectedToInternet).localizedDescription)
                XCTAssertTrue(viewModel.results.isEmpty)
                XCTAssertFalse(viewModel.isLoading)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_paginationAppendsResults() {
        // Arrange
        let mockLoader = MockDiscogsSearchLoader()
        mockLoader.results = [ArtistSearchResult(id: 1, title: "Artist 1", thumb: "")]
        mockLoader.totalPages = 2 // simulate two pages
        let viewModel = SearchViewModel()
        viewModel.discogsLoader = mockLoader
        
        let expectation = expectation(description: "wait for pagination searchFinishedPublisher emissions")
        expectation.expectedFulfillmentCount = 2
        
        var searchResults: [[ArtistSearchResult]] = []
        
        viewModel
            .searchFinishedPublisher
            .scan(0) { count, _ in
                count + 1
            }
            .sink { count in
                searchResults.append(viewModel.results)

                // after the first page load, request the next page after stub the mock
                if count == 1 {
                    mockLoader.results = [ArtistSearchResult(id: 2, title: "Artist 2", thumb: "")] // Simulamos datos para la segunda página
                    viewModel.loadNextPage() // load next page
                }
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Act
        viewModel.query = "Test" // load first search

        
        wait(for: [expectation], timeout: 1)
        
        // Assert
        XCTAssertEqual(searchResults.count, 2)
        
        // check the first page partial result
        XCTAssertEqual(searchResults[0].count, 1)
        XCTAssertEqual(searchResults[0].first?.title, "Artist 1")
        
        // check the next result after the pagination
        XCTAssertEqual(searchResults[1].count, 2)
        XCTAssertEqual(searchResults[1].first?.title, "Artist 1")
        XCTAssertEqual(searchResults[1].last?.title, "Artist 2")
    }
}
