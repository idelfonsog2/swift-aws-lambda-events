//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftAWSLambdaRuntime open source project
//
// Copyright (c) 2017-2022 Apple Inc. and the SwiftAWSLambdaRuntime project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftAWSLambdaRuntime project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

/// APIGatewayV2Request contains data coming from the new HTTP API Gateway
public struct APIGatewayV2Request: Codable {
    /// Context contains the information to identify the AWS account and resources invoking the Lambda function.
    public struct Context: Codable {
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

        public let accountId: String
        public let apiId: String
        public let domainName: String
        public let domainPrefix: String
        public let stage: String
        public let requestId: String
        
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

    public let context: Context

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

        case context = "requestContext"
        case stageVariables

        case body
        case isBase64Encoded
    }
}


public struct APIGatewayV2Response: Codable {
    public var statusCode: HTTPResponseStatus
    public var headers: HTTPHeaders?
    public var body: String?
    public var isBase64Encoded: Bool?
    public var cookies: [String]?

    public init(
        statusCode: HTTPResponseStatus,
        headers: HTTPHeaders? = nil,
        body: String? = nil,
        isBase64Encoded: Bool? = nil,
        cookies: [String]? = nil
    ) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
        self.isBase64Encoded = isBase64Encoded
        self.cookies = cookies
    }
}

#if swift(>=5.6)
extension APIGatewayV2Request: Sendable {}
extension APIGatewayV2Request.Context: Sendable {}
extension APIGatewayV2Request.Context.HTTP: Sendable {}
extension APIGatewayV2Request.Context.Authorizer: Sendable {}
extension APIGatewayV2Response: Sendable {}
#endif
