//
//  SchoolListTVC.swift
//  20230810-NirzarGandhi-NYCSchools
//

class SchoolListTVC: UITableViewCell {

    //MARK: - UILabel Outlets
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!

    //MARK: - Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
