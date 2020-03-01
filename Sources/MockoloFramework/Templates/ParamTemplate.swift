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

func applyParamTemplate(name: String,
                        label: String,
                        type: Type,
                        inInit: Bool) -> String {
    var result = name
    if !label.isEmpty {
        result = "\(label) \(name)"
    }
    if !type.isUnknown {
        result = "\(result): \(type.typeName)"
    }
    
    if inInit, let defaultVal = type.defaultVal() {
        result = "\(result) = \(defaultVal)"
    }
    return result
}

func applyVarTemplate(name: String,
                      type: Type) -> String {
    assert(!type.isUnknown)
    let vardecl = "\(1.tab)private var \(name.safeName): \(type.underlyingType)"
    return vardecl
}
