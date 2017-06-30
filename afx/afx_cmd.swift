//#!/usr/bin/swift

import AppKit

let token = "80F81AC50DA4458D8C46AFA3DCF8E451"

let pb = NSPasteboard.general
let home = String(validatingUTF8: getenv("HOME")) ?? ""
let cmd_prefix = token + " "

while true {
    sleep(1)
    guard let s = pb.string(forType: NSPasteboard.PasteboardType.string), s.hasPrefix(cmd_prefix) else {
        continue
    }

    pb.clearContents()

    let start = s.index(after: cmd_prefix.endIndex)
    let cmd = s.substring(from: start)

    print(cmd)
    let bs = "__(BACKSLASH)__"
    let cmdx = cmd
        .replacingOccurrences(of: "\\\\"    , with: bs)
        .replacingOccurrences(of: "C:\\"    , with: "\\")
        .replacingOccurrences(of: "Z:\\"    , with: "\\")
        .replacingOccurrences(of: "\\"      , with: "/")
        .replacingOccurrences(of: "$HOME"   , with: home)
        .replacingOccurrences(of: bs        , with: "\\")

    print(cmdx)

    var args = cmdx.components(separatedBy: "\t")
    guard let path = args.first else {
        continue
    }
    args.remove(at: 0)
    print("->", path, args)
    Process.launchedProcess(launchPath: path, arguments: args)
}
