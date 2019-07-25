//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import SourceKittenFramework

func applyClosureTemplate(name: String,
                          type: String,
                          typeKeys: [String: String]?,
                          genericTypeNames: [String],
                          paramVals: [String]?,
                          paramTypes: [String]?,
                          suffix: String,
                          returnAs: String,
                          returnDefaultType: String) -> String {
    let handlerParamValsStr = paramVals?.joined(separator: ", ") ?? ""
    let handlerReturnDefault = renderReturnDefaultStatement(name: name, type: returnDefaultType, typeKeys: typeKeys)

    var returnTypeCast = ""
    if !returnAs.isEmpty {
        let asSuffix = returnAs.hasSuffix("?") ? "?" : "!"

        var returnAsStr = returnAs
        if returnAsStr.hasSuffix("?") || returnAsStr.hasSuffix("!") {
            returnAsStr.removeLast()
        }

        returnTypeCast = " as\(asSuffix) " + returnAsStr
    }
    
    let prefix = suffix.isThrowsOrRethrows ? String.forceTry + " " : ""
    
    let returnStr = returnDefaultType.isEmpty ? "" : "return "
    let callExpr = "\(returnStr)\(prefix)\(name)(\(handlerParamValsStr))\(returnTypeCast)"
    
    let template = """
    
            if let \(name) = \(name) {
                \(callExpr)
            }
            \(handlerReturnDefault)
    """

    return template
}


private func renderReturnDefaultStatement(name: String, type: String, typeKeys: [String: String]?) -> String {
    if type != .unknownVal, !type.isEmpty {
        if type.contains("->") {
            return "\(String.fatalError)(\"\(name) returns can't have a default value thus its handler must be set\")"
        }
        
        let result = processDefaultVal(typeName: type, typeKeys: typeKeys) ?? String.fatalError
        
        if result.isEmpty {
            return ""
        }
        if result.contains(String.fatalError) {
            return "\(String.fatalError)(\"\(name) returns can't have a default value thus its handler must be set\")"
        }
        return  "return \(result)"
    }
    return ""
}
