import Foundation

protocol RestorePoint{
    var filesInArchive: [FileResoreCopyInfo] { get }
    var filesInPoint: [FileResoreCopyInfo] { get }
    var size: Double { get }
    var typeOfStorage: TypeOfStorage { get }
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
