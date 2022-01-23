//
//  AppEnvironment.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation

public enum AppEnvironment {
    public enum Endpoint {
        /// API host
        public static let host: String = #"618d3aa7fe09aa001744060a.mockapi.io"#
        
        /// URL scheme for API requests
        public static let scheme: String = #"https"#
        
        public enum Paths {
            /// General part of URL for using mock API
            public static let basePath: String = #"api"#
        }
    }
}
