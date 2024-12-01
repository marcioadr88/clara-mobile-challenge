//
//  RemoteDiscogsLoader+GetArtistDetails Tests.swift
//  Clara Mobile ChallengeTests
//
//  Created by Marcio Duarte on 2024-11-30.
//

import XCTest
@testable import Clara_Mobile_Challenge

extension RemoteDiscogsLoaderTests {
    func test_getArtistDetails_makesRequestToCorrectURL() async throws {
        // Given
        let artistID = 12345
        let artistDetailURLPath = "/artists/\(artistID)"
        let (sut, spy) = makeSUT()
        
        // when
        spy.completeNextRequest(
            withStatusCode: 200,
            data: try makeArtistDetailJSON(makeArtistDetail(id: artistID))
        )
        
        _ = try await sut.getArtistDetails(artistID: artistID)
        
        // then
        let fullURLString = spy.request?.url?.absoluteString
        
        XCTAssertTrue(
            fullURLString?.hasSuffix(artistDetailURLPath) ?? false,
            "The URL doesn't ends with \(artistDetailURLPath), the full URL is \(String(describing: fullURLString))"
        )
    }
    
    func test_getArtistDetails_deliversArtistDetailOn200HTTPResponseWithValidJSON() async throws {
        let artistDetail = makeArtistDetail()
        let jsonData = try makeArtistDetailJSON(artistDetail)
        let (sut, spy) = makeSUT()
        
        spy.completeNextRequest(withStatusCode: 200, data: jsonData)
        
        let receivedDetail = try await sut.getArtistDetails(artistID: artistDetail.id)
        
        XCTAssertEqual(receivedDetail, artistDetail)
    }
    
    func test_getArtistDetails_deliversErrorOnNon200HTTPResponse() async {
        // given
        let (sut, spy) = makeSUT()
        let artistID = 1234
        
        // when
        spy.completeNextRequest(withStatusCode: 404, data: Data())
        
        // then
        do {
            let _ = try await sut.getArtistDetails(artistID: artistID)
            XCTFail("Expected error, got no error instead")
        } catch RemoteDiscogsLoaderError.serverError {
            // ok
        } catch {
            XCTFail("Catched error \(error) but not the expected .serverError")
        }
    }
    
    func test_getArtistDetails_deliversErrorOnInvalidJSON() async {
        let (sut, spy) = makeSUT()
        
        spy.completeNextRequest(withStatusCode: 200, data: "invalid-data".data(using: .utf8)!)
        
        do {
            _ = try await sut.getArtistDetails(artistID: 12345)
            XCTFail("No error received, espected .invalidData")
        } catch RemoteDiscogsLoaderError.invalidData {
            // ok
        } catch {
            XCTFail("Received error \(error) but not the expected, expected .invalidData")
        }
    }
    
    
    func makeArtistDetail(id: Int = 1) -> ArtistDetail {
        ArtistDetail(
            id: id,
            name: "Artist Name",
            profile: "The artist profile",
            imageURL: nil,
            releasesURL: "http://a.release.url",
            urls: nil,
            members: nil
        )
    }
    
    func makeArtistDetailJSON(_ artistDetail: ArtistDetail) throws -> Data {
        let dict: [String: Any] = [
            "id": artistDetail.id,
            "name": artistDetail.name,
            "profile": artistDetail.profile ?? "",
            "images": artistDetail.imageURL != nil ? [["uri": artistDetail.imageURL!]] : [],
            "releases_url": artistDetail.releasesURL,
            "urls": artistDetail.urls ?? [],
            "members": artistDetail.members?.map { member in
                ["id": member.id, "name": member.name]
            } ?? []
        ]
        
        return try makeJSONFromDictionary(dict)
    }
}

extension ArtistDetail: Equatable {
    public static func == (lhs: ArtistDetail, rhs: ArtistDetail) -> Bool {
        lhs.id == rhs.id
    }
}
