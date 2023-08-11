//
//  SchoolDetailsVC.swift
//  20230810-NirzarGandhi-NYCSchools
//

class SchoolDetailsVC: UIViewController {

    //MARK: - UILabel Outlets
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblLocations: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblTotalStudents: UILabel!
    @IBOutlet weak var lblAcademicOpportunities1: UILabel!
    @IBOutlet weak var lblAcademicOpportunities2: UILabel!
    @IBOutlet weak var lblExtracurricularActivities: UILabel!
    @IBOutlet weak var lblSchoolSports: UILabel!
    @IBOutlet weak var lblBusNumbers: UILabel!
    @IBOutlet weak var lblTestTakers: UILabel!
    @IBOutlet weak var lblMathsScore: UILabel!
    @IBOutlet weak var lblReadingScore: UILabel!
    @IBOutlet weak var lblWritingScore: UILabel!

    //MARK: - Varialbe Declaration
    var dictSchoolInfo : SchoolListModel?
    var dictSchoolSATInfo : SchoolSATInfoModel?

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()

        setData()
    }

    //MARK: - Initialization Method
    private func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - UIButton Action Method
    @IBAction func btnCloseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Set Data Method
    private func setData() {

        if dictSchoolInfo != nil {
            lblSchoolName.text = dictSchoolInfo?.school_name ?? ""

            lblLocations.text = dictSchoolInfo?.location ?? ""

            lblPhoneNumber.text = dictSchoolInfo?.phone_number ?? ""

            lblEmailId.text = dictSchoolInfo?.school_email ?? ""

            lblWebsite.text = dictSchoolInfo?.website ?? ""

            lblTotalStudents.text = dictSchoolInfo?.total_students ?? ""

            lblAcademicOpportunities1.text = dictSchoolInfo?.academicopportunities1 ?? ""

            lblAcademicOpportunities2.text = dictSchoolInfo?.academicopportunities2 ?? ""

            lblExtracurricularActivities.text = dictSchoolInfo?.extracurricular_activities ?? ""

            lblSchoolSports.text = dictSchoolInfo?.school_sports ?? ""

            lblBusNumbers.text = dictSchoolInfo?.bus ?? ""
        } else {
            lblSchoolName.text = ""

            lblLocations.text = ""

            lblPhoneNumber.text = ""

            lblEmailId.text = ""

            lblWebsite.text = ""

            lblTotalStudents.text = ""

            lblAcademicOpportunities1.text = ""

            lblAcademicOpportunities2.text = ""

            lblExtracurricularActivities.text = ""

            lblSchoolSports.text = ""

            lblBusNumbers.text = ""
        }

        if dictSchoolSATInfo != nil {
            lblTestTakers.text = dictSchoolSATInfo?.num_of_sat_test_takers ?? ""

            lblMathsScore.text = dictSchoolSATInfo?.sat_math_avg_score ?? ""

            lblReadingScore.text = dictSchoolSATInfo?.sat_critical_reading_avg_score ?? ""

            lblWritingScore.text = dictSchoolSATInfo?.sat_writing_avg_score ?? ""
        } else {
            lblTestTakers.text = ""

            lblMathsScore.text = ""

            lblReadingScore.text = ""

            lblWritingScore.text = ""
        }
    }
}
