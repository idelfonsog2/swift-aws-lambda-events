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

/// IAMPolicyEvent use to send IAM Policy data to APIGateway
/// It's use case is for using custom authorizer to your API
/// Note:
/// - APIGatway caches this output
/// - Does not call your authorizer for the same token
/// - the policy only allows to call a current function, a call to a different function will fail
///
/// In order to avoid the last point, set the TTL to 0, which, it will cause it not to cache the results.
/// Another option, is to set all the reources a user can access in the result policy ('*')
public struct IAMPolicyEvent: Encodable {
    let principalID: String
    let policyDocument: PolicyDocument

    struct PolicyDocument: Encodable {
        let version: String
        let statement: [Statement]
    }

    struct Statement: Encodable {
        let action: String
        let effect: String
        let resource: String
    }
}

#if swift(>=5.6)
extension IAMPolicyEvent: Sendable {}
#endif
