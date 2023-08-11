//
//  AppDelegate+Configuration.swift
//  20230810-NirzarGandhi-NYCSchools
// 

//MARK: - AppDelegate Extension
extension AppDelegate {
    
    //MARK: - Config App Method
    func configApp() {
        
        strMainURL = isSimulatorOrTestFlight() ? WebServiceURL.mainDevURL : WebServiceURL.mainLiveURL

        setRootController()
    }

    //MARK: - Is Simulator Or TestFlight Method
    func isSimulatorOrTestFlight() -> Bool {

        guard let path = Bundle.main.appStoreReceiptURL?.path else {
            return false
        }

        return path.contains("CoreSimulator") || path.contains("sandboxReceipt")
    }
    
    //MARK: - Set Root Controller Method
    func setRootController() {
        Utility().setRootSchoolListVC()
    }
}
