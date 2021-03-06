//
//  SearchNetworkRequestor.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Alamofire

// MARK: - SearchEnvironment
enum SearchEnvironment {
    static let baseURLString: String = { return "\(Environment.serverURLString)/api/search" }()
}

// MARK: - NetworkRequestor (Search)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func searchByQuery(_ query: String, completion: @escaping (Result<SearchResponsePage, AFError>) -> Swift.Void) {
        guard let components = URLComponents(string: SearchEnvironment.baseURLString, item: URLQueryItem(name: "query", value: query)),
              let urlString = components.url?.absoluteString
        else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(urlString, completion: completion)
    }
}
