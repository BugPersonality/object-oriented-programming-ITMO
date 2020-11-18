import Foundation

protocol RestorePoint{
    var filesInPoint: [FileResoreCopyInfo] { get }
    var size: Double { get }
    var type: TypeOfPoint { get }
    var date: String { get }
    func getTotalSizeOfPoint(files: [FileInfo]) -> Double
}

extension RestorePoint{
    func getTotalSizeOfPoint(files: [FileInfo]) -> Double {
        var totalSize = 0.0
       
        for file in files{
            totalSize += file.fileSize
        }
        
        return totalSize
    }
}
