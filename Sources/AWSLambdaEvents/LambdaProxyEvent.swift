//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftAWSLambdaRuntime open source project
//
// Copyright (c) 2022 Apple Inc. and the SwiftAWSLambdaRuntime project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftAWSLambdaRuntime project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

public struct LambdaProxyEvent: Codable {
    public struct RequestContext: Codable {
        public struct HTTP: Codable {
            public let httpMethod: HTTPMethod
            public let path: String
            public let `protocol`: String
            public let sourceIp: String
            public let userAgent: String
        }

        /// Authorizer contains authorizer information for the request context.
        public struct Authorizer: Codable {
            public let claims: [String: String]?
            public let scopes: [String]?
        }

        public let accountID: String
        public let apiID: String
        public let domainName: String
        public let domainPrefix: String
        public let stage: String
        public let requestID: String
        
        public let httpMethod: HTTPMethod
        public let authorizer: Authorizer?

        public let resourcePath: String?
        public let path: String?
        
        /// The request time in format: 23/Apr/2020:11:08:18 +0000
        public let time: String?
        public let requestTime: String?
        public let requestTimeEpoch: UInt64
    }

    public let resource: String
    public let path: String
    public let httpMethod: String
    public let stageVariables: [String: String]?
    
    public let cookies: [String]?
    public let headers: HTTPHeaders
    public let queryStringParameters: [String: String]?
    public let pathParameters: [String: String]?

    public let requestContext: RequestContext

    public let body: String?
    public let isBase64Encoded: Bool

    enum CodingKeys: String, CodingKey {
        case resource
        case path
        case httpMethod

        case cookies
        case headers
        case queryStringParameters
        case pathParameters

        case requestContext
        case stageVariables

        case body
        case isBase64Encoded
    }
}

#if swift(>=5.6)
extension LambdaProxyEvent: Sendable {}
extension LambdaProxyEvent.RequestContext: Sendable {}
extension LambdaProxyEvent.RequestContext.HTTP: Sendable {}
extension LambdaProxyEvent.RequestContext.Authorizer: Sendable {}
#endif
