//
//  ResultState.swift
//  iOSTaskApp
//
//  Created by Saravanan R on 26/10/23.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}

