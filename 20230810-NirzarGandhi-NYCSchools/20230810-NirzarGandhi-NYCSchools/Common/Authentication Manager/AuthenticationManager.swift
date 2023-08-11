//
//  AuthenticationManager.swift
//  20230810-NirzarGandhi-NYCSchools
//

//MARK: - Authentication Manager Class
class AuthenticationManager : NSObject {
    
    //MARK: - Variable Declaration
    static let shared = AuthenticationManager()
    
    //MARK: - Authenticate Method
    func authenticate(completion: @escaping ((Bool) -> ())) {
        
        let authenticationContext = LAContext()
        var error:NSError?
        
        let isValidSensor : Bool = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        
        if isValidSensor {
            authenticationContext.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: "Touch / Face ID authentication",
                reply: { [unowned self] (success, error) -> Void in
                    if success {
                        completion(true)
                    } else {
                        if let error = error {
                            let strMessage = self.checkErrorMessage(errorCode: error._code)
                            if strMessage != "" {
                                mainThread {
                                    Utility().dynamicToastMessage(strMessage: "Error - \(strMessage)")
                                }
                            }
                        }
                        completion(false)
                    }
                })
        } else {
            let strMessage = self.checkErrorMessage(errorCode: (error?._code)!)
            if strMessage != "" {
                mainThread {
                    Utility().dynamicToastMessage(strMessage: "Error - \(strMessage)")
                }
            }
        }
    }
    
    //MARK: - Check Error Message Method
    func checkErrorMessage(errorCode : Int) -> String {
        
        var strMessage = ""
        
        switch errorCode {
            
        case LAError.Code.authenticationFailed.rawValue:
            strMessage = "Authentication Failed"
            
        case LAError.Code.userCancel.rawValue:
            strMessage = "User Cancel"
            
        case LAError.Code.systemCancel.rawValue:
            strMessage = "System Cancel"
            
        case LAError.Code.passcodeNotSet.rawValue:
            strMessage = "Please goto the Settings & Turn On Passcode"
            
        case LAError.Code.biometryNotAvailable.rawValue:
            strMessage = "TouchI or FaceID DNot Available"
            
        case LAError.Code.biometryNotEnrolled.rawValue:
            strMessage = "TouchID or FaceID Not Enrolled"
            
        case LAError.Code.biometryLockout.rawValue:
            strMessage = "TouchID or FaceID Lockout Please goto the Settings & Turn On Passcode"
            
        case LAError.Code.appCancel.rawValue:
            strMessage = "App Cancel"
            
        case LAError.Code.invalidContext.rawValue:
            strMessage = "Invalid Context"
            
        default:
            strMessage = ""
        }
        
        return strMessage
    }
}

//MARK: - LAContext Extension
extension LAContext {
    
    enum BiometricType: String {
        case none
        case touchID
        case faceID
    }
    
    var biometricType: BiometricType {
        var error: NSError?
        
        guard self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return .none
        }
        
        if #available(iOS 11.0, *) {
            switch self.biometryType {
                
            case .none:
                return .none
                
            case .touchID:
                return .touchID
                
            case .faceID:
                return .faceID
                
            default:
                return .none
            }
        } else {
            return  self.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touchID : .none
        }
    }
}
