import Foundation

enum TypeOfPoint{
    case incremental
    case full
}

enum TypeOfStorage{
    case jointStorage
    case separateStorage
}

enum GybridType{
    case wentBeyondOne(maxCountOfPoints: Int?, dateUntilWhichDeleteAll: String?, maxSizeOfAllPointInBytes: Double?)
    case wentBeyondAll(maxCountOfPoints: Int?, dateUntilWhichDeleteAll: String?, maxSizeOfAllPointInBytes: Double?)
}

enum PoinCleaningType{
    case countOfPoints(maxCountOfPoints: Int)
    case dateOfPoints(dateUntilWhichDeleteAll: String)
    case sizeOfPoint(maxSizeOfAllPointInBytes: Double)
    case gybrid(type: GybridType)
}
