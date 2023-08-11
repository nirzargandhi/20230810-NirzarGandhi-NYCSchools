//
//  SchoolListVC.swift
//  20230810-NirzarGandhi-NYCSchools
//

class SchoolListVC: UIViewController {

    //MARK: - UITextField Outlet
    @IBOutlet weak var txtSearch: UITextField!

    //MARK: - UITableView Outlet
    @IBOutlet weak var tblSchoolList: UITableView!

    //MARK: - UILabel Outlet
    @IBOutlet weak var lblNoData: UILabel!

    //MARK: - Variable Declaration
    var arrMainSchoolList : [SchoolListModel]?
    var arrSchoolList : [SchoolListModel]?
    var arrSchoolSATInfo : [SchoolSATInfoModel]?

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()

        callSchoolDetailInfoAPI()

        callSchoolSATInfo()
    }

    //MARK: - Initialization Method
    func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - Call API Methods
    private func callSchoolDetailInfoAPI() {

        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AlertMessage.msgNetworkConnection)
            return
        }

        ServiceRequest().wsSchoolDetailInfo() { [weak self] (success, responseData) in

            guard let self else { return }

            if success, let responseData = responseData as? [SchoolListModel] {

                arrMainSchoolList = responseData
                arrSchoolList = responseData

                setData()
            } else {
                mainThread {
                    Utility().dynamicToastMessage(strMessage: responseData != nil ? Utility().wsFailResponseMessage(responseData: responseData!) : AlertMessage.msgError)

                    self.setData()
                }
            }
        }
    }

    private func callSchoolSATInfo() {

        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AlertMessage.msgNetworkConnection)
            return
        }

        ServiceRequest().wsSchoolSATInfo() { [weak self] (success, responseData) in

            guard let self else { return }

            if success, let responseData = responseData as? [SchoolSATInfoModel] {
                arrSchoolSATInfo = responseData
            } else {
                mainThread {
                    Utility().dynamicToastMessage(strMessage: responseData != nil ? Utility().wsFailResponseMessage(responseData: responseData!) : AlertMessage.msgError)
                }
            }
        }
    }

    //MARK: - Set Data Method
    func setData() {

        if arrSchoolList?.count ?? 0 > 0 {
            tblSchoolList.reloadData()

            tblSchoolList.isHidden = false
            lblNoData.isHidden = true
        } else {
            lblNoData.isHidden = false
            tblSchoolList.isHidden = true
        }
    }
}
