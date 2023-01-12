//
//  CustomError+Extensions.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "failed to get data your request."
    case .addressUnreachable: return "the url is unreachable."
    }
  }

}
