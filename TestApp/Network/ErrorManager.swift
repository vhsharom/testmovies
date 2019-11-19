//
//  ErrorManager.swift
//  HelloGas
//
//

import Foundation
import UIKit

enum ErrorType : String {
    
    init?(message : String) {
        self.init(rawValue: message)
    }
    
    // None
    case None = "None"
    // Data Errors
    case CantCreateString = "Error al procesar respuesta"
    case CantParseJson = "Error al procesar Json"
    case EmptyDataResponse = "Respuesta vacia"
    case DataNotFound = "Datos no encontrados"
    
    // Session Error
    case LoginInvalid = "Credenciales inválidas"
    case WrongHash = "Datos inválidos"
    
    // HTTP Error
    case HostNotFound = "Servidor no se encuentra"
    case MethodNotAllowed = "Método no permitido"
    case ServerError = "Error de Servidor"
    case GatewayTimeout = "Expiró el tiempo de la conexión"
    
    // NSError
    case Cancelled = "Conexión cancelada"
    case CannotFindHost = "Servidor no encontrado"
    case TimedOut = "Expiró el tiempo de conexión"
    case CannotConnectToHost = "No se puede establecer la conexión con el servidor"
    case NetworkConnectionLost = "Se ha perdido la conexión"
    case HTTPTooManyRedirects = "Redirect"
    case ResourceUnavailable = "Recurso no disponible"
    case NotConnectedToInternet = "Revisa tu conexión a Internet"
    case UnknownError = "Error desconocido"
    case SSLError = "Error de certificado"
    
}

class _Error: NSObject {
    
    var errorType = ErrorType.None
    var errorMessage = ""
    
    override init() {
        super.init()
    }
    
    init(errorType : ErrorType) {
        super.init()
        self.errorType = errorType
        self.errorMessage = self.errorType.rawValue
    }
    
    init(errorMessage : String){
        super.init()
        self.errorMessage = errorMessage
    }
    
    // HTTP Errors
    
    init(httpResponse : HTTPURLResponse) {
        super.init()
        switch httpResponse.statusCode{
        case 404:
            errorType = ErrorType.HostNotFound
            errorMessage = errorType.rawValue
        case 405:
            errorType = ErrorType.MethodNotAllowed
            errorMessage = errorType.rawValue
        case 500:
            errorType = ErrorType.ServerError
            errorMessage = errorType.rawValue
        case 504:
            errorType = ErrorType.GatewayTimeout
            errorMessage = errorType.rawValue
        default:
            NSLog("httpResponse.statusCode: \(httpResponse.statusCode)")
            errorType = ErrorType.UnknownError
            errorMessage = "Error: \(httpResponse.statusCode)"
        }
        
    }
    
    // NSError
    
    init(theError : Error) {
        super.init()
        
        let error = theError as NSError
        
        print("Error Code \(error.code) \(error.localizedDescription)")
        
        switch error.code{
        case -999:
            errorType = ErrorType.Cancelled
        case -1001:
            errorType = ErrorType.TimedOut
        case -1003:
            errorType = ErrorType.CannotFindHost
        case -1004:
            errorType = ErrorType.CannotConnectToHost
        case -1005:
            errorType = ErrorType.NetworkConnectionLost
        case -1007:
            errorType = ErrorType.HTTPTooManyRedirects
        case -1008:
            errorType = ErrorType.ResourceUnavailable
        case -1009:
            errorType = ErrorType.NotConnectedToInternet
        case -1202:
            errorType = ErrorType.SSLError
        case -1203:
            errorType = ErrorType.SSLError
        case -1204:
            errorType = ErrorType.SSLError
        case -1205:
            errorType = ErrorType.SSLError
        case -1206:
            errorType = ErrorType.SSLError
        default:
            NSLog("error.code: \(error.code)")
            errorType = ErrorType.UnknownError
        }
        errorMessage = errorType.rawValue
    }
    
    func getMessage() -> String{
        return errorMessage
    }
    
}

