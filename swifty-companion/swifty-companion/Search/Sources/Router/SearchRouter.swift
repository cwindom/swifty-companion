//
//  SearchRouter.swift
//  swifty-companion
//
//  Created by Корогодова Мария Михайловна on 15.05.2022.
//

import UIKit
import OAuth2
import Alamofire
import AuthenticationServices

struct User: Decodable {
  var login: String
  var name: String
}

struct NetworkRequest {
    
    // MARK: Private Constants
    static let callbackURLScheme = "YOUR_CALLBACK_SCHEME_HERE"
    static let clientID = "5b5e17939a353679df61518bffb9a186da960681aae7932e320efd2aabf62f3d"
    static let clientSecret = "215f5c2da8d2f7ec54104a862eb02f8041a8055472d334e23e186a16244e7b85"

    // MARK: Properties
    var method: HTTPMethod
    var url: URL
}
extension NetworkRequest {
  // MARK: Private Constants
  private static let accessTokenKey = "accessToken"
  private static let refreshTokenKey = "refreshToken"
  private static let usernameKey = "username"

  // MARK: Properties
  static var accessToken: String? {
    get {
      UserDefaults.standard.string(forKey: accessTokenKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: accessTokenKey)
    }
  }

  static var refreshToken: String? {
    get {
      UserDefaults.standard.string(forKey: refreshTokenKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey)
    }
  }

  static var username: String? {
    get {
      UserDefaults.standard.string(forKey: usernameKey)
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: usernameKey)
    }
  }
}


extension NetworkRequest {
  enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
  }

  enum RequestError: Error {
    case invalidResponse
    case networkCreationError
    case otherError
    case sessionExpired
  }

  enum RequestType: Equatable {
    case codeExchange(code: String)
    case getRepos
    case getUser
    case signIn

    func networkRequest() -> NetworkRequest? {
      guard let url = url() else {
        return nil
      }
      return NetworkRequest(method: httpMethod(), url: url)
    }

    private func httpMethod() -> NetworkRequest.HTTPMethod {
      switch self {
      case .codeExchange:
        return .get
      case .getRepos:
        return .get
      case .getUser:
        return .get
      case .signIn:
        return .get
      }
    }

      private func url() -> URL? {
          switch self {
          case .codeExchange(let code):
              let queryItems = [
                URLQueryItem(name: "client_id", value: NetworkRequest.clientID),
                          URLQueryItem(name: "client_secret", value: NetworkRequest.clientSecret)//,
//                URLQueryItem(name: "redirect_uri", value: "redirect"),
//                URLQueryItem(name: "scope", value: "public"),
//                URLQueryItem(name: "state", value: "publifgjfsfe5df423jlf9r8vuwjrjvf84rudvjc"),
//                URLQueryItem(name: "responce_type", value: code)
              ]
              return urlComponents(host: "api.intra.42.fr", path: "/oauth/token", queryItems: queryItems).url
          case .getRepos:
              guard
                let username = NetworkRequest.username,
                !username.isEmpty
              else {
                  return nil
              }
              return urlComponents(path: "/users/\(username)/repos", queryItems: nil).url
          case .getUser:
              return urlComponents(path: "/user", queryItems: nil).url
          case .signIn:
              let queryItems = [
                URLQueryItem(name: "client_id", value: NetworkRequest.clientID)
              ]
              
              return urlComponents(host: "api.intra.42.fr", path: "/oauth/authorize", queryItems: queryItems).url
          }
      }

    private func urlComponents(host: String = "api.intra.42.fr", path: String, queryItems: [URLQueryItem]?) -> URLComponents {
      switch self {
      default:
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
      }
    }
  }

  typealias NetworkResult<T: Decodable> = (response: HTTPURLResponse, object: T)

  // MARK: Static Methods
  static func signOut() {
    Self.accessToken = ""
    Self.refreshToken = ""
    Self.username = ""
  }

  // MARK: Methods
    func start<T: Decodable>(responseType: T.Type, completionHandler: @escaping ((Result<NetworkResult<T>, Error>) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let accessToken = NetworkRequest.accessToken {
            request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(RequestError.invalidResponse))
                }
                return
            }
            guard
                error == nil,
                let data = data
            else {
                DispatchQueue.main.async {
                    let error = error ?? NetworkRequest.RequestError.otherError
                    completionHandler(.failure(error))
                }
                return
            }
            // 1
            if T.self == String.self,
              let responseString = String(data: data, encoding: .utf8) {
              // 2
              let components = responseString.components(separatedBy: "&")
              var dictionary: [String: String] = [:]
              // 3
              for component in components {
                let itemComponents = component.components(separatedBy: "=")
                if let key = itemComponents.first,
                   let value = itemComponents.last {
                  dictionary[key] = value
                }
              }
              // 4
              DispatchQueue.main.async {
                // 5
                NetworkRequest.accessToken = dictionary["access_token"]
                NetworkRequest.refreshToken = dictionary["refresh_token"]
                completionHandler(.success((response, "Success" as! T)))
              }
              return
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    if let user = object as? User {
                        NetworkRequest.username = user.login
                    }
                    completionHandler(.success((response, object)))
                }
                return
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(NetworkRequest.RequestError.otherError))
                }
            }
        }
        session.resume()
    }
}

final class SearchRouter {
    
    weak var viewController: UIViewController?
    
    var webAuthSession: ASWebAuthenticationSession?
    
    init(viewController: UIViewController? = nil) {
        
        self.viewController = viewController
    }
    
}

extension SearchRouter: SearchRouterInput {

    func openProfileModule() {
        
//         переход в настоящий будущий модуль, отключила для тестов oauth
//        let module = ProfileBuilder().build()
//        viewController?.navigationController?.pushViewController(module, animated: true)
    }
    
    func closeModule() {
        
        viewController?.navigationController?.popViewController(animated: true)
    }
}
