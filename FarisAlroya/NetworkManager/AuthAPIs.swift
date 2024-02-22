////
////  AuthAPIs.swift
////  KEENZALARAB
////
////  Created by Osama Abu hdba on 09/01/2024.
////
//
//import Foundation
//import Moya
//
//enum AuthAPIs: TargetType {
//    case login(LoginBody)
//    case register(RegisterBody)
//    case getHashtags
//    case getCountryCodes
//
//    var path: String {
//        switch self {
//        case .login: return "user/login"
//        case .register: return "user/register"
//        case .getHashtags: return "frontend/getHashtags"
//        case .getCountryCodes: return "frontend/getCountryPhoneKeys"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .login: return .post
//        case .register: return .post
//        case .getHashtags: return .post
//        case .getCountryCodes: return .post
//        }
//    }
//
//    var task: Task {
//        switch self {
//        case .login(let body):
//            let params: [String: String] = [
//                "user_name":"\(body.user_name)",
//                "password":"\(body.password)",
//            ]
//
//            var multipartData = [MultipartFormData]()
//
//            for (key, value) in params {
//                let formData = MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
//                multipartData.append(formData)
//            }
//
//            return .uploadMultipart(multipartData)
//
//        case .register(let body):
//            let params: [String: String] = [
//                "lang":"en",
//                "first_name":"\(body.first_name)",
//                "last_name":"\(body.last_name)",
//                "user_name":"\(body.user_name)",
//                "password":"\(body.password)",
//                "date_of_birth":"\(body.date_of_birth)",
//                "phone":"\(body.phone)",
//                "email":"\(body.email)",
//                "sex":"\(body.sex)",
//                "country_phone_id":"\(body.country_phone_id)",
//            ]
//
//            var multipartData = [MultipartFormData]()
//            body.hashtags_ids.forEach { id in
//                let formData = MultipartFormData(provider: .data("\(id)".data(using: .utf8)!), name: "hashtags_ids[\(id)]")
//                multipartData.append(formData)
//            }
//
//            for (key, value) in params {
//                let formData = MultipartFormData(provider: .data(value.data(using: .utf8)!), name: key)
//                multipartData.append(formData)
//            }
//
//            return .uploadMultipart(multipartData)
//
//        case .getHashtags:
//            return .requestPlain
//
//        case .getCountryCodes:
//            return .requestPlain
//        }
//    }
//}
