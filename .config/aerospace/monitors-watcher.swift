import Foundation

let logPath = "/tmp/aerospace-monitor-watcher.log"
let aerospace = "/opt/homebrew/bin/aerospace"

func logMsg(_ msg: String) {
    let line = "\(Date()) \(msg)\n"
    guard let data = line.data(using: .utf8) else { return }
    if let fh = FileHandle(forWritingAtPath: logPath) {
        fh.seekToEndOfFile(); fh.write(data); fh.closeFile()
    } else {
        try? data.write(to: URL(fileURLWithPath: logPath))
    }
}

func getMonitors() -> String {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: aerospace)
    task.arguments = ["list-monitors"]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = Pipe()
    try? task.run()
    task.waitUntilExit()
    return String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
}

func runAssign() {
    let home = ProcessInfo.processInfo.environment["HOME"] ?? ""
    let script = "\(home)/.config/aerospace/monitors-assign.sh"
    logMsg("running assign")
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/bin/bash")
    task.arguments = [script]
    let pipe = Pipe()
    task.standardOutput = pipe; task.standardError = pipe
    try? task.run()
    task.waitUntilExit()
    let out = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
    logMsg("done (exit \(task.terminationStatus)): \(out)")
}

logMsg("watcher started")
var lastMonitors = getMonitors()
runAssign()

// Poll every 4 seconds — covers both hardware monitors and Sidecar (AirPlay)
Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
    let current = getMonitors()
    if current != lastMonitors {
        logMsg("monitors changed:\n\(current)")
        lastMonitors = current
        runAssign()
    }
}

RunLoop.main.run()
