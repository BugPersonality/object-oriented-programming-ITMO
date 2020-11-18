import Foundation

func printLineIntoFile(filePath: String){
    //-----------------
    let task = Process()
    let pipe = Pipe()
    let command = "echo My new text in file >> \(filePath)"

    task.standardOutput = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/bash"
    task.launch()
    //-----------------
}

func timeForClean() -> String{
    let dateNow = DateNow().getDate()
    let dateNowArray = dateNow.components(separatedBy: " ")
    var timeNowArray = dateNowArray[1].components(separatedBy: ":")

    if Int(timeNowArray[1])! <= 58{
        timeNowArray[1] = "59"
    }else{
        timeNowArray[0] = "23"
    }

    let timeNow = timeNowArray.joined(separator: ":")
    let _dateNow = dateNowArray[0] + " " + timeNow
    return _dateNow
}
