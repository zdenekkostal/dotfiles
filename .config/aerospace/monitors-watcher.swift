import CoreGraphics
import Foundation

func runAssign() {
    let home = ProcessInfo.processInfo.environment["HOME"] ?? ""
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/bin/bash")
    task.arguments = ["\(home)/.config/aerospace/monitors-assign.sh"]
    try? task.run()
    task.waitUntilExit()
}

// Run once on startup
runAssign()

// Watch for display connect/disconnect
CGDisplayRegisterReconfigurationCallback({ _, flags, _ in
    let relevant: CGDisplayChangeSummaryFlags = [.addFlag, .removeFlag, .enabledFlag, .disabledFlag]
    guard !flags.intersection(relevant).isEmpty else { return }
    runAssign()
}, nil)

RunLoop.main.run()
