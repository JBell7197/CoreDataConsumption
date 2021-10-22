import UIKit

struct Basketball {
    func teamAtlantaHawks() {
        print("Atl Hawks: 2nd quarter (51 pts)")
        Thread.sleep(forTimeInterval: 3)
        print("Atl Hawks: Final Score (110 pts)")
    }
}

struct Baseball {
    func teamAtlantaBraves () {
        print("Atl Braves score: 1")
        Thread.sleep(forTimeInterval: 3)
        print("Atl Braves final score: 3")
    }
}

struct Football {
    func teamAtlantaFalcons () {
        print("Atl Falcons 2nd quarter score: 7")
        Thread.sleep(forTimeInterval: 3)
        print("Atl Falcons final score: 21")
    }
}

struct SyncManager {

    func syncATLTeams() {


        let atlHawksScoreOperation = BlockOperation() //creates operation named 'employeeSyncOperation'
        atlHawksScoreOperation.addExecutionBlock { //executes operation
        let basketball = Basketball()
        basketball.teamAtlantaHawks()
        }


        let atlBravesScoreOperation = BlockOperation() //creates operation
        atlHawksScoreOperation.addExecutionBlock { //executes operation
            let baseball = Baseball()
            baseball.teamAtlantaBraves()
        }

        let atlFalconsScoreOperation = BlockOperation() //creates operation
        atlFalconsScoreOperation.addExecutionBlock { //executes operation
            let football = Football()
            football.teamAtlantaFalcons()
        }
        //Department has dependency on employee
        atlHawksScoreOperation.addDependency(atlBravesScoreOperation)
        atlFalconsScoreOperation.addDependency(atlHawksScoreOperation)

        let operationQue = OperationQueue() // creating operation queue named 'operationQue
        //puts operations in OperationQueue()
        operationQue.addOperation (atlHawksScoreOperation)
        operationQue.addOperation (atlBravesScoreOperation)
        operationQue.addOperation (atlFalconsScoreOperation)

    }
}

let syncObj = SyncManager()
syncObj.syncATLTeams()
