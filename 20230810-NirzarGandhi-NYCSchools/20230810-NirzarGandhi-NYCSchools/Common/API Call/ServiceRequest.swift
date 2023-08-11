//
//  ServiceRequest.swift
//  20230810-NirzarGandhi-NYCSchools
//

//MARK: - Service Request Struct
struct ServiceRequest {

    //MARK: - Webservice Call Methods
    func wsSchoolDetailInfo(completion : @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {

        ApiCall().get(apiUrl: WebServiceURL.allSchoolDetailInfo, model: [SchoolListModel].self) { (success, responseData) in

            if success {
                completion(true, responseData)
            } else {
                completion(false, responseData)
            }
        }
    }

    func wsSchoolSATInfo(completion : @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {

        ApiCall().get(apiUrl: WebServiceURL.allSchoolSATInfo, model: [SchoolSATInfoModel].self, isLoader: false) { (success, responseData) in

            if success {
                completion(true, responseData)
            } else {
                completion(false, responseData)
            }
        }
    }
}
