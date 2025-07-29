//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let expectation = expectation(description: "Invalid URL")

        
        sut.fetchUsers(urlString: "https:// jsonplaceholder.typicode.com/ users") { result in
            switch result {
            case .success:
                XCTFail("Success on expected failure")
                expectation.fulfill()
                
            case .failure(let failure):
                XCTAssertEqual(failure, APIError.invalidUrl)
                expectation.fulfill()
                
            }
        }
        waitForExpectations(timeout: 1)
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let expectation = expectation(description: "Success response with fetching users")

        
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                XCTAssertEqual(users[0].id, 1)
                XCTAssertEqual(users[0].name, "John Doe")
                XCTAssertEqual(users[0].username, "johndoe")
                XCTAssertEqual(users[0].email, "johndoe@gmail.com")
                XCTAssertEqual(users[1].id, 2)
                XCTAssertEqual(users[1].name, "Jane Doe")
                XCTAssertEqual(users[1].username, "johndoe")
                XCTAssertEqual(users[1].email, "johndoe@gmail.com")
                expectation.fulfill()
                
            case .failure:
                XCTFail("Failure on expected success")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let invalidResponse = "Definitely not json file!!!".data(using: .utf8)
        mockURLSession.mockData = invalidResponse
        
        let sut = makeSut()
        let expectation = expectation(description: "Failure response with parsing error")

        
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result {
            case .success:
                XCTFail("Success on expected failure")
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertEqual(failure, APIError.parsingError)
                expectation.fulfill()
                
            }
        }
        waitForExpectations(timeout: 1)
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        let networkError = NSError(domain: "I'm a teapot", code: 418, userInfo: nil)
        mockURLSession.mockError = networkError
        
        let sut = makeSut()
        let expectation = expectation(description: "Network error completion")

        
        sut.fetchUsers(urlString: "https://jsonplaceholder.typicode.com/users") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, APIError.unexpected)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https:// jsonplaceholder.typicode.com/ users")
        
        switch result {
        case .success:
            XCTFail("Success on expected failure")
        case .failure(let failure):
            XCTAssertEqual(failure, APIError.invalidUrl)
        }
    }


    // add other tests for fetchUsersAsync
    func test_apiService_fetchUsersAsync_whenValidSuccessfulResponse_completesWithSuccess() async {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        
        switch result {
        case .success(let users):
            XCTAssertEqual(users.count, 2)
            XCTAssertEqual(users[0].id, 1)
            XCTAssertEqual(users[0].name, "John Doe")
            XCTAssertEqual(users[0].username, "johndoe")
            XCTAssertEqual(users[0].email, "johndoe@gmail.com")
            XCTAssertEqual(users[1].id, 2)
            XCTAssertEqual(users[1].name, "Jane Doe")
            XCTAssertEqual(users[1].username, "johndoe")
            XCTAssertEqual(users[1].email, "johndoe@gmail.com")
        case .failure:
            XCTFail("Failure on expected success")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenInvalidSuccessfulResponse_completesWithFailure() async {
        let invalidResponse = "Definitely not json file!!!".data(using: .utf8)
        mockURLSession.mockData = invalidResponse
        
        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        
        switch result {
        case .success:
            XCTFail("Success on expected failure")
        case .failure(let failure):
            XCTAssertEqual(failure, APIError.parsingError)
        }
        
    }
    
    func test_apiService_fetchUsersAsync_whenError_completesWithFailure() async {
        let networkError = NSError(domain: "I'm a teapot", code: 418, userInfo: nil)
        mockURLSession.mockError = networkError
        
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "https://jsonplaceholder.typicode.com/users")
        
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, APIError.unexpected)
        }
    }
    

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
