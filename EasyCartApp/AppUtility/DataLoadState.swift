//
//  DataState.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 31/12/25.
//

import Foundation

enum DataLoadState<DataType> {

  case loading
  case loaded(data: DataType)
  case error

  var data: DataType? {
    switch self {
    case .loading, .error:
      return nil
    case .loaded(let data):
      return data
    }
  }

}
