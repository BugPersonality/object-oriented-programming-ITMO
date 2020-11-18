import Foundation

enum BackupError: Error {
    case ArrayEmptyError(String)
    case AddingAnExistingFileError(String)
    case NoSuchFileOrDirectoryError(String)
    case BackupAlreadyCreated
    case NothingHasChangedInFiles
    case IncorrectArgumentsInCleaner(String)
}

