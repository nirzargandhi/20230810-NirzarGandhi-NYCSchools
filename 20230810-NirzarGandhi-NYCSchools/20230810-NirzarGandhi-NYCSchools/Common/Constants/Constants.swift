//
//  Constants.swift
//

//MARK: - Colors
extension UIColor {

    class func appBackground() -> UIColor { return UIColor(named: "AppBackground")! }
    class func appBorderGray() -> UIColor { return UIColor(named: "AppBorderGray")! }
    class func appButtonBg() -> UIColor { return UIColor(named: "AppButtonBg")! }
    class func appGray() -> UIColor { return UIColor(named: "AppGray")! }
    class func appPrimaryFont() -> UIColor { return UIColor(named: "AppPrimaryFont")! }
}

//MARK: - Global
enum GlobalConstants {
    
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {

    static let kSchoolListVC = "SchoolListVC"
    static let kSchoolDetailsVC = "SchoolDetailsVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {

    static let kCellSchoolList = "CellSchoolList"
}

//MARK: - Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgComingSoon = "Coming soon"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images and ALbums Related Messages
    static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let msgCameraPermission = "Please enable camera access from Privacy Settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    static let msgSelectPhoto = "Please select photo"
    static let msgNotFoundBackCamera = "Could not find a back camera"
    static let msgNotCreateVideoDevice = "Could not create video device input"
    static let msgNotAddVideoInputSession = "Could not add video device input to the session"
    static let msgNotAdVideoOutputSession = "Could not add video data output to the session"
    
    //Unauthorized & InActive Message
    static let msgUnauthorized = "You are unauthorized. Please login again"
    static let msgInactiveLogout = "You have been automatically logged out due to inactivity"

    //General API Error Messages
    static let msgError = "Oops! That didn't work. Please try later :("
    static let msgError500 = "Error code 500 or more"
    static let msgError402 = "Payment required, go to coins packages"
    static let msgError403 = "User forbidden"
    
    //No data found Message
    static let msgNoDataFound = "No data found"
    
    //Validation Messages
    static let msgFirstName = "Please enter first name"
    static let msgValidCharacterFirstName = "First name must contain atleast 2 characters and maximum 30 characters"
    static let msgValidFirstName = "Please enter valid first name"

    static let msgLastName = "Please enter last name"
    static let msgValidCharacterLastName = "Last name must contain atleast 2 characters and maximum 30 characters"
    static let msgValidLastName = "Please enter valid last name"
    
    static let msgName = "Please enter name"
    static let msgValidCharacterName = "Name must contain atleast 2 characters and maximum 60 characters"
    static let msgValidName = "Please enter valid name"
    
    static let msgEmailPhoneNumber = "Please enter email address or phone number"

    static let msgEmail = "Please enter email address"
    static let msgValidEmail = "Please enter valid email address"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 16 characters"
    static let msgValidPassword = "Password should contain atleast 8 characters, one uppercase letter, one letter"

    //Logout Message
    static let msgLogout = "Are you sure you want to log out from the application?"
}

//MARK: - Web Service URLs
enum WebServiceURL {
    
    //Dev URL
    static let mainDevURL = "https://data.cityofnewyork.us/resource/"

    //Live URL
    static let mainLiveURL = "https://data.cityofnewyork.us/resource/"

    static let allSchoolDetailInfo = strMainURL + "s3k6-pzi2.json"
    static let allSchoolSATInfo = strMainURL + "f9bf-2cp4.json"
}

//MARK: - Web Service Parameters
enum WebServiceParameter {

    static let pEmail = "email"
    static let pPassword = "password"
}

//MARK: - User Default
enum UserDefaultsKey {

}

//MARK: - Constants
struct Constants {
    
    //MARK: - Device Type
    enum UIUserInterfaceIdiom : Int {
        
        case Unspecified
        case Phone
        case Pad
    }
    
    //MARK: - Screen Size
    struct ScreenSize {
        
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
}

//MARK: - DateTime Format
enum DateAndTimeFormatString {

    static let strDateFormat_yyyymmddHHmmss = "yyyy-MM-dd HH:mm:ss"
    static let strDateFormat_yyyymmddHHmmssZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let strDateFormat_yyyyMMdd = "yyyy/MM/dd"
}

//MARK: - Fonts
struct Fonts {

    static let InterBold24 = UIFont(name: "Inter-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
    static let InterSemiBold14 = UIFont(name: "Inter-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold)
    static let InterMedium16 = UIFont(name: "Inter-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .medium)
    static let InterRegular14 = UIFont(name: "Inter-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
}
