//
//  HomeModels.swift
//  aywa
//
//  Created by Zoeb on 19/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import ObjectMapper

let sectionURL = "/sections"

enum Home
{
    // MARK: Use cases
    
    enum Section
    {
        struct Request
        {
            func baseRequest() -> BaseRequest {
                let baseRequest = BaseRequest()
                baseRequest.urlPath = sectionURL
                baseRequest.parameters[Constants.kIncludeShowsKey] = Constants.kIncludeShowsValue
                baseRequest.parameters[Constants.kCatalogIdKey] = 0 // 2 For home Screen
                baseRequest.parameters[Constants.kMenuSectionsOnlyKey] = Constants.kMenuSectionsOnlyValue
                baseRequest.parameters[BaseRequest.hasArrayResponse] = true
                return baseRequest
            }
        }
        // Request For Browse For sections
        
        struct RequestForBrowseSection
        {
            func baseRequest() -> BaseRequest {
                let baseRequest = BaseRequest()
                baseRequest.urlPath = sectionURL
               // baseRequest.parameters[Constants.kMenuSectionsOnlyKey] = Constants.kMenuSectionsTrueValue
                baseRequest.parameters[Constants.kMenuSectionsOnlyKey] = Constants.kMenuSectionsTrueValue
                baseRequest.parameters[Constants.kIncludeShowsKey] = Constants.kMenuSectionsTrueValue
                baseRequest.parameters[BaseRequest.hasArrayResponse] = true
                return baseRequest
            }
        }
        
        struct Response: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let sectionUrl = "SectionUrl"
                static let catalogId = "CatalogId"
                static let showType = "ShowType"
                static let name = "Name"
                static let shows = "Shows"
                static let configuration = "Configuration"
                static let displayOrder = "DisplayOrder"
                static let disableOrderBy = "DisableOrderBy"
                static let id = "Id"
                static let message = "Message"
            }
            
            // MARK: Properties
            public var sectionUrl: String?
            public var catalogId: Int?
            public var showType: Int?
            public var name: String?
            public var shows: [Shows]?
            public var configuration: String?
            public var displayOrder: Int?
            public var disableOrderBy: Bool? = false
            public var id: Int?
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
                sectionUrl <- map[SerializationKeys.sectionUrl]
                catalogId <- map[SerializationKeys.catalogId]
                showType <- map[SerializationKeys.showType]
                name <- map[SerializationKeys.name]
                shows <- map[SerializationKeys.shows]
                configuration <- map[SerializationKeys.configuration]
                displayOrder <- map[SerializationKeys.displayOrder]
                disableOrderBy <- map[SerializationKeys.disableOrderBy]
                id <- map[SerializationKeys.id]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                
                var dictionary: [String: Any] = [:]
                if let value = sectionUrl { dictionary[SerializationKeys.sectionUrl] = value }
                if let value = catalogId { dictionary[SerializationKeys.catalogId] = value }
                if let value = showType { dictionary[SerializationKeys.showType] = value }
                if let value = name { dictionary[SerializationKeys.name] = value }
                if let value = shows { dictionary[SerializationKeys.shows] = value.map { $0.dictionaryRepresentation() } }
                if let value = configuration { dictionary[SerializationKeys.configuration] = value }
                if let value = displayOrder { dictionary[SerializationKeys.displayOrder] = value }
                dictionary[SerializationKeys.disableOrderBy] = disableOrderBy
                if let value = id { dictionary[SerializationKeys.id] = value }
                if let value = message { dictionary[SerializationKeys.message] = value }
                return dictionary
            }
            
        }
        public struct Shows: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let urlId = "UrlId"
                static let isAvailable = "IsAvailable"
                static let percentWatched = "PercentWatched"
                static let image2x2 = "Image2x2"
                static let title = "Title"
                static let image3x2 = "Image3x2"
                static let userRatings = "UserRatings"
                static let image1x2 = "Image1x2"
                static let id = "Id"
                static let summary = "Summary"
                static let showWatchUrl = "ShowWatchUrl"
                static let availabilityStatus = "AvailabilityStatus"
                static let titleImage = "TitleImage"
                static let image1x1 = "Image1x1"
                static let showType = "ShowType"
                static let catalogId = "CatalogId"
                static let urlIdArabic = "UrlIdArabic"
                static let releaseYear = "ReleaseYear"
                static let industryRating = "IndustryRating"
                static let length = "Length"
                static let showUrl = "ShowUrl"
            }
            
            // MARK: Properties
            public var urlId: String?
            public var isAvailable: Bool? = false
            public var percentWatched: Int?
            public var image2x2: String?
            public var title: String?
            public var image3x2: String?
            public var userRatings: Int?
            public var image1x2: String?
            public var id: Int?
            public var summary: String?
            public var showWatchUrl: String?
            public var availabilityStatus: String?
            public var titleImage: String?
            public var image1x1: String?
            public var showType: Int?
            public var catalogId: Int?
            public var urlIdArabic: String?
            public var releaseYear: Int?
            public var industryRating: IndustryRating?
            public var length: Int?
            public var showUrl: String?
            
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
                urlId <- map[SerializationKeys.urlId]
                isAvailable <- map[SerializationKeys.isAvailable]
                percentWatched <- map[SerializationKeys.percentWatched]
                image2x2 <- map[SerializationKeys.image2x2]
                title <- map[SerializationKeys.title]
                image3x2 <- map[SerializationKeys.image3x2]
                userRatings <- map[SerializationKeys.userRatings]
                image1x2 <- map[SerializationKeys.image1x2]
                id <- map[SerializationKeys.id]
                summary <- map[SerializationKeys.summary]
                showWatchUrl <- map[SerializationKeys.showWatchUrl]
                availabilityStatus <- map[SerializationKeys.availabilityStatus]
                titleImage <- map[SerializationKeys.titleImage]
                image1x1 <- map[SerializationKeys.image1x1]
                showType <- map[SerializationKeys.showType]
                catalogId <- map[SerializationKeys.catalogId]
                urlIdArabic <- map[SerializationKeys.urlIdArabic]
                releaseYear <- map[SerializationKeys.releaseYear]
                industryRating <- map[SerializationKeys.industryRating]
                length <- map[SerializationKeys.length]
                showUrl <- map[SerializationKeys.showUrl]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                var dictionary: [String: Any] = [:]
                if let value = urlId { dictionary[SerializationKeys.urlId] = value }
                dictionary[SerializationKeys.isAvailable] = isAvailable
                if let value = percentWatched { dictionary[SerializationKeys.percentWatched] = value }
                if let value = image2x2 { dictionary[SerializationKeys.image2x2] = value }
                if let value = title { dictionary[SerializationKeys.title] = value }
                if let value = image3x2 { dictionary[SerializationKeys.image3x2] = value }
                if let value = userRatings { dictionary[SerializationKeys.userRatings] = value }
                if let value = image1x2 { dictionary[SerializationKeys.image1x2] = value }
                if let value = id { dictionary[SerializationKeys.id] = value }
                if let value = summary { dictionary[SerializationKeys.summary] = value }
                if let value = showWatchUrl { dictionary[SerializationKeys.showWatchUrl] = value }
                if let value = availabilityStatus { dictionary[SerializationKeys.availabilityStatus] = value }
                if let value = titleImage { dictionary[SerializationKeys.titleImage] = value }
                if let value = image1x1 { dictionary[SerializationKeys.image1x1] = value }
                if let value = showType { dictionary[SerializationKeys.showType] = value }
                if let value = catalogId { dictionary[SerializationKeys.catalogId] = value }
                if let value = urlIdArabic { dictionary[SerializationKeys.urlIdArabic] = value }
                if let value = releaseYear { dictionary[SerializationKeys.releaseYear] = value }
                if let value = industryRating { dictionary[SerializationKeys.industryRating] = value.dictionaryRepresentation() }
                if let value = length { dictionary[SerializationKeys.length] = value }
                if let value = showUrl { dictionary[SerializationKeys.showUrl] = value }
                return dictionary
            }
            
        }
        public struct IndustryRating: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let code = "Code"
                static let description = "Description"
            }
            
            // MARK: Properties
            public var code: String?
            public var description: String?
            
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
                code <- map[SerializationKeys.code]
                description <- map[SerializationKeys.description]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                var dictionary: [String: Any] = [:]
                if let value = code { dictionary[SerializationKeys.code] = value }
                if let value = description { dictionary[SerializationKeys.description] = value }
                return dictionary
            }
            
        }
        
        struct ViewModel
        {
        }
    }
}
