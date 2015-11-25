#!/usr/bin/swift

import AppKit

let token = "80F81AC50DA4458D8C46AFA3DCF8E451"

let pb = NSPasteboard.generalPasteboard()
let home = String.fromCString(getenv("HOME")) ?? ""
let cmd_prefix = token + " "

while true {
    sleep(1)
    guard let s = pb.stringForType(NSPasteboardTypeString) where s.hasPrefix(cmd_prefix) else {
        continue
    }

    pb.clearContents()

    let start = s.startIndex.advancedBy(cmd_prefix.characters.count)
    let end = s.endIndex
    let cmd = s.substringWithRange(Range<String.Index>(start: start, end: end))

    let bs = "__(BACKSLASH)__"
    let cmdx = cmd
               .stringByReplacingOccurrencesOfString("\\\\", withString: bs)
               .stringByReplacingOccurrencesOfString("C:\\", withString: "\\")
               .stringByReplacingOccurrencesOfString("Z:\\", withString: "\\")
               .stringByReplacingOccurrencesOfString("\\", withString: "/")
               .stringByReplacingOccurrencesOfString("$HOME", withString: home)
               .stringByReplacingOccurrencesOfString(bs, withString: "\\")

    print(cmdx)
    cmdx.withCString { c -> () in
        let ret = system(c)
        if ret != 0 {
            print("Error")
        }
    }
}
