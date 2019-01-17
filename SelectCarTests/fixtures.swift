//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

let emptyInfoJSON = """
{"page": 1, "pageSize": 0, "totalPageCount": 0, "wkda":{}}
"""

let someJSON = """
{"page": 1, "pageSize": 20, "totalPageCount": 0, "wkda":{
    "CR-V" : "CR-V",
    "FR-V" : "FR-V",
    "HR-V" : "HR-V"
}}
"""

let lastPageJSON = """
{"page": 122, "pageSize": 20, "totalPageCount": 123, "wkda":{
    "CR-V" : "CR-V",
    "FR-V" : "FR-V",
    "HR-V" : "HR-V"
}}
"""

let someURL = URL(string: "https://some.host.com/path?query&param=value")!
