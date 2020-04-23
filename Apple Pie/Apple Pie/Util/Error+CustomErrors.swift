//
//  Error+CustomErrors.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/12/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

enum RuntimeError: Error {
    case illegalArgumentError(String)
}
