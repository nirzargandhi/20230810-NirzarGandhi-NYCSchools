//
//  GeneralResponseModel.swift
//  20230810-NirzarGandhi-NYCSchools
//

struct GeneralResponseModel : Codable {
    let error : String?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
}
