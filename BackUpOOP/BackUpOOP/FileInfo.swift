import Foundation

class FileInfo {
    var fileName: String
    var createDate: String
    var fileSize: Double
    
    init(name: String, date: String, size: Double) {
        self.fileName = name
        self.createDate = date
        self.fileSize = size
    }
}
