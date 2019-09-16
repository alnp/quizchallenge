enum NetworkError: String, Error {
    case noConnection = "No network connection"
    case parametersNil = "Paramenters were nil"
    case encodingFailed = "Paramenter encoding failed"
    case missingURL = "URL is nil"
    
    case badRequest = "Bad Request"
    case failed = "Network request failed"
    case noData = "Response returned with no data to encode"
    case unableToDecode = "Unable to decode the response"
}
