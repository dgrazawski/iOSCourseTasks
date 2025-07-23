import Foundation

let declaredSemaphore = DispatchSemaphore(value: 2)

func performTask(id: Int) {
    print("Task \(id) started")
    sleep(1) // Simulate a task taking time
    print("Task \(id) finished")
}

func runConcurrentTasks() {
    let threads = (1...5).map { id in
        Thread {
            declaredSemaphore.wait()
            performTask(id: id)
            declaredSemaphore.signal()
        }
    }

    threads.forEach { $0.start() }
}

runConcurrentTasks()
