import UIKit

func someQueue() {
    let firstQueue = DispatchQueue(label: "com.app.queue", qos: .userInitiated)
    let secondQueue = DispatchQueue(label: "com.app.secondQ", qos: .utility)

    secondQueue.async {
        for item in 1..<100 {
            print(item)
        }
    }
    firstQueue.async {
        for item in 200..<300 {
            print(item)
        }
    }
}

print(someQueue())
