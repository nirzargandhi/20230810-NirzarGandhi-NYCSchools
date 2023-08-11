//
//  SchoolListVC+UITableViewDelegate+UITableViewDataSource.swift
//  20230810-NirzarGandhi-NYCSchools
//

//MARK: - UITableViewDelegate & UITableViewDataSource Extension
extension SchoolListVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSchoolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.kCellSchoolList, for: indexPath) as! SchoolListTVC

        cell.lblSchoolName.text = arrSchoolList?[indexPath.row].school_name ?? ""

        cell.lblLocation.text = arrSchoolList?[indexPath.row].location ?? ""

        cell.lblPhoneNumber.text = arrSchoolList?[indexPath.row].phone_number ?? ""

        cell.lblEmailId.text = arrSchoolList?[indexPath.row].school_email ?? ""

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let objSchoolDetailsVC = AllStoryBoard.Main.instantiateViewController(withIdentifier: ViewControllerName.kSchoolDetailsVC) as! SchoolDetailsVC

        objSchoolDetailsVC.dictSchoolInfo = arrSchoolList?[indexPath.row] ?? nil

        if arrSchoolSATInfo?.contains(where: {$0.dbn == (arrSchoolList?[indexPath.row].dbn ?? "")}) ?? false {
            let index = arrSchoolSATInfo?.indices(where: {$0.dbn == (arrSchoolList?[indexPath.row].dbn ?? "")})
            objSchoolDetailsVC.dictSchoolSATInfo = arrSchoolSATInfo?[index?[0] ?? 0] ?? nil
        }

        self.navigationController?.pushViewController(objSchoolDetailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

