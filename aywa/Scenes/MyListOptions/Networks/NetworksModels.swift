//
//  NetworksModels.swift
//  aywa
//
//  Created by Bestpeers on 09/01/18.
//  Copyright (c) 2018 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import ObjectMapper
let myListNetworksURL = "/mylist/shows"

enum Networks
{
    // MARK: Use cases
    
    enum MyListNetworks
    {
        struct Request
        {
            func baseRequest() -> BaseRequest {
                let baseRequest = BaseRequest()
                baseRequest.urlPath = myListNetworksURL
                baseRequest.parameters[Constants.kShowTypesKey] = NumericValue.THREE.rawValue
                baseRequest.parameters[BaseRequest.hasArrayResponse] = true
                return baseRequest
            }
        }
        struct Response: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let urlId = "UrlId"
                static let isAvailable = "IsAvailable"
                static let image2x2 = "Image2x2"
                static let percentWatched = "PercentWatched"
                static let title = "Title"
                static let image3x2 = "Image3x2"
                static let userRatings = "UserRatings"
                static let image1x2 = "Image1x2"
                static let id = "Id"
                static let showWatchUrl = "ShowWatchUrl"
                static let availabilityStatus = "AvailabilityStatus"
                static let image1x1 = "Image1x1"
                static let catalogId = "CatalogId"
                static let showType = "ShowType"
                static let releaseYear = "ReleaseYear"
                static let genres = "Genres"
                static let showUrl = "ShowUrl"
                static let length = "Length"
                static let message = "Message"
            }
            
            // MARK: Properties
            public var urlId: String?
            public var isAvailable: Bool? = false
            public var image2x2: String?
            public var percentWatched: Int?
            public var title: String?
            public var image3x2: String?
            public var userRatings: Int?
            public var image1x2: String?
            public var id: Int?
            public var showWatchUrl: String?
            public var availabilityStatus: String?
            public var image1x1: String?
            public var catalogId: Int?
            public var showType: Int?
            public var releaseYear: Int?
            public var genres: [Genres]?
            public var showUrl: String?
            public var length: Int?
            public var message: String?
            // MARK: ObjectMapper Initializers
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public init?(map: Map){
                
            }
            public init?(message: String){
                self.message = message
            }
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public mutating func mapping(map: Map) {
                urlId <- map[SerializationKeys.urlId]
                isAvailable <- map[SerializationKeys.isAvailable]
                image2x2 <- map[SerializationKeys.image2x2]
                percentWatched <- map[SerializationKeys.percentWatched]
                title <- map[SerializationKeys.title]
                image3x2 <- map[SerializationKeys.image3x2]
                userRatings <- map[SerializationKeys.userRatings]
                image1x2 <- map[SerializationKeys.image1x2]
                id <- map[SerializationKeys.id]
                showWatchUrl <- map[SerializationKeys.showWatchUrl]
                availabilityStatus <- map[SerializationKeys.availabilityStatus]
                image1x1 <- map[SerializationKeys.image1x1]
                catalogId <- map[SerializationKeys.catalogId]
                showType <- map[SerializationKeys.showType]
                releaseYear <- map[SerializationKeys.releaseYear]
                genres <- map[SerializationKeys.genres]
                showUrl <- map[SerializationKeys.showUrl]
                length <- map[SerializationKeys.length]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                var dictionary: [String: Any] = [:]
                if let value = urlId { dictionary[SerializationKeys.urlId] = value }
                dictionary[SerializationKeys.isAvailable] = isAvailable
                if let value = image2x2 { dictionary[SerializationKeys.image2x2] = value }
                if let value = percentWatched { dictionary[SerializationKeys.percentWatched] = value }
                if let value = title { dictionary[SerializationKeys.title] = value }
                if let value = image3x2 { dictionary[SerializationKeys.image3x2] = value }
                if let value = userRatings { dictionary[SerializationKeys.userRatings] = value }
                if let value = image1x2 { dictionary[SerializationKeys.image1x2] = value }
                if let value = id { dictionary[SerializationKeys.id] = value }
                if let value = showWatchUrl { dictionary[SerializationKeys.showWatchUrl] = value }
                if let value = availabilityStatus { dictionary[SerializationKeys.availabilityStatus] = value }
                if let value = image1x1 { dictionary[SerializationKeys.image1x1] = value }
                if let value = catalogId { dictionary[SerializationKeys.catalogId] = value }
                if let value = showType { dictionary[SerializationKeys.showType] = value }
                if let value = releaseYear { dictionary[SerializationKeys.releaseYear] = value }
                if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
                if let value = showUrl { dictionary[SerializationKeys.showUrl] = value }
                if let value = length { dictionary[SerializationKeys.length] = value }
                if let value = message { dictionary[SerializationKeys.message] = value }
                return dictionary
            }
            
        }
        
        struct Genres: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let title = "Title"
                static let noSubgenreSection = "NoSubgenreSection"
                static let genreUrl = "GenreUrl"
                static let position = "Position"
                static let catalogId = "CatalogId"
                static let id = "Id"
            }
            
            // MARK: Properties
            public var title: String?
            public var noSubgenreSection: Bool? = false
            public var genreUrl: String?
            public var position: Int?
            public var catalogId: Int?
            public var id: Int?
            
            // MARK: ObjectMapper Initializers
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public init?(map: Map){
                
            }
            
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public mutating func mapping(map: Map) {
                title <- map[SerializationKeys.title]
                noSubgenreSection <- map[SerializationKeys.noSubgenreSection]
                genreUrl <- map[SerializationKeys.genreUrl]
                position <- map[SerializationKeys.position]
                catalogId <- map[SerializationKeys.catalogId]
                id <- map[SerializationKeys.id]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                var dictionary: [String: Any] = [:]
                if let value = title { dictionary[SerializationKeys.title] = value }
                dictionary[SerializationKeys.noSubgenreSection] = noSubgenreSection
                if let value = genreUrl { dictionary[SerializationKeys.genreUrl] = value }
                if let value = position { dictionary[SerializationKeys.position] = value }
                if let value = catalogId { dictionary[SerializationKeys.catalogId] = value }
                if let value = id { dictionary[SerializationKeys.id] = value }
                return dictionary
            }
            
        }
        struct ViewModel
        {
        }
    }
}
