//
//  ApiCall.swift
//

class ApiCall: NSObject {

    let session = URLSession(configuration: URLSessionConfiguration.default)

    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func get<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func delete<T : Decodable, A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "DELETE", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestPutMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "PUT", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func patch<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestPatchMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "PATCH", model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if isLoader {
                Utility().hideLoader()
            }
            
            guard let data = data, error == nil else {
                completion(false, error as AnyObject)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    mainThread {
                        logoutUserAutomatically()

                        completion(false, AlertMessage.msgUnauthorized as AnyObject)
                    }
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if data.count > 0 {
                            let dictResponse = try decoder.decode(model, from: data)
                            mainThread {
                                completion(true, dictResponse as AnyObject)
                            }
                        } else {
                            mainThread {
                                completion(true, nil)
                            }
                        }
                    } else {
                        mainThread {
                            completion(false, AlertMessage.msgError as AnyObject)
                        }
                    }
                }
            } catch let error as NSError {
                
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                print(error)
                print("===========================\n\n")

                print(error)
                
                completion(false, error as AnyObject)
            }
        })
        
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData)
        request.httpMethod = method
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        request.setValue("*/*", forHTTPHeaderField: "Accept")

        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if isLoader {
                Utility().hideLoader()
            }
            
            guard let data = data, error == nil else {
                completion(false, error as AnyObject)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    mainThread {
                        logoutUserAutomatically()

                        completion(false, AlertMessage.msgUnauthorized as AnyObject)
                    }
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if data.count > 0 {
                            let dictResponse = try decoder.decode(model, from: data)
                            mainThread {
                                completion(true, dictResponse as AnyObject)
                            }
                        } else {
                            mainThread {
                                completion(true, nil)
                            }
                        }
                    } else {
                        mainThread {
                            completion(false, AlertMessage.msgError as AnyObject)
                        }
                    }
                }
            } catch let error as NSError {
                
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                print(error)
                print("===========================\n\n")

                print(error)
                
                completion(false, error as AnyObject)
            }
        })
        
        task.resume()
    }
    
    func requestDeleteMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if isLoader {
                Utility().hideLoader()
            }
            
            guard let data = data, error == nil else {
                completion(false, error as AnyObject)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    mainThread {
                        logoutUserAutomatically()

                        completion(false, AlertMessage.msgUnauthorized as AnyObject)
                    }
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if data.count > 0 {
                            let dictResponse = try decoder.decode(model, from: data)
                            mainThread {
                                completion(true, dictResponse as AnyObject)
                            }
                        } else {
                            mainThread {
                                completion(true, nil)
                            }
                        }
                    } else {
                        mainThread {
                            completion(false, AlertMessage.msgError as AnyObject)
                        }
                    }
                }
            } catch let error as NSError {
                
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                print(error)
                print("===========================\n\n")

                print(error)
                
                completion(false, error as AnyObject)
            }
        })
        
        task.resume()
    }
    
    func requestPutMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: String, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if isLoader {
                Utility().hideLoader()
            }
            
            guard let data = data, error == nil else {
                completion(false, error as AnyObject)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    mainThread {
                        logoutUserAutomatically()

                        completion(false, AlertMessage.msgUnauthorized as AnyObject)
                    }
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if data.count > 0 {
                            let dictResponse = try decoder.decode(model, from: data)
                            mainThread {
                                completion(true, dictResponse as AnyObject)
                            }
                        } else {
                            mainThread {
                                completion(true, nil)
                            }
                        }
                    } else {
                        mainThread {
                            completion(false, AlertMessage.msgError as AnyObject)
                        }
                    }
                }
            } catch let error as NSError {
                
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                print(error)
                print("===========================\n\n")

                print(error)
                
                completion(false, error as AnyObject)
            }
        })
        
        task.resume()
    }
    
    func requestPatchMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: String, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            return
        }
        
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if isLoader {
                Utility().hideLoader()
            }
            
            guard let data = data, error == nil else {
                completion(false, error as AnyObject)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                    mainThread {
                        logoutUserAutomatically()

                        completion(false, AlertMessage.msgUnauthorized as AnyObject)
                    }
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                        print(convertedJsonIntoDict)
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if data.count > 0 {
                            let dictResponse = try decoder.decode(model, from: data)
                            mainThread {
                                completion(true, dictResponse as AnyObject)
                            }
                        } else {
                            mainThread {
                                completion(true, nil)
                            }
                        }
                    } else {
                        mainThread {
                            completion(false, AlertMessage.msgError as AnyObject)
                        }
                    }
                }
            } catch let error as NSError {
                
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                print(error)
                print("===========================\n\n")

                print(error)
                
                completion(false, error as AnyObject)
            }
        })
        
        task.resume()
    }
}
