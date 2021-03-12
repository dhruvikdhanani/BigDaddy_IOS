
import Foundation

import UIKit

func callRestApi(_ methodName: String, methodType: METHOD_TYPE, parameters: typeAliasDictionary, contentType:CONTENT_TYPE,showLoding: Bool=true, useToken: Bool? = true, onCompletion: @escaping (_ dictServiceContent: typeAliasDictionary) -> Void) {
    
    if showLoding {
        showLoder()
    }
    if Reachability.isConnectedToNetwork(){
        print("Internet Connection Available!")
        _ = DispatchSemaphore (value: 0)
        
        let dictParameters: typeAliasDictionary = parameters
        
        var theRequest: URLRequest!
        
        dLog(message: "Call \(methodName) PARAMETERS:\(parameters)")
        var dataBody = Data()
        
        var stMethodType: String = ""
        
        switch methodType {
        case .GET:
            stMethodType = "GET"
            var stData: String = ""
            var i: Int = 0
            for (pKey, pvalue) in dictParameters {
                if pvalue is String {
                    stData = "\(pKey)=\((pvalue as! String).addingPercentEncodingForQueryParameter()!)"
                    stData = i == 0 ? stData : "&\(stData)"
                    dataBody.append(stData.data(using: .utf8)!)
                    i += 1
                }
            }
            if contentType == .FORM_DATA { //FORM_DATA
                
                theRequest = URLRequest(url: URL(string: API_ROOT + "\(methodName)")!)
                theRequest.httpMethod = stMethodType
                let boundary = generateBoundary()
                
                theRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                let dataBody = createDataBody(withParameters: dictParameters, boundary: boundary)
                
                theRequest.httpBody = dataBody
                
            }else if contentType == .X_WWW_FORM { //X_WWW_FORM
                let headers = ["content-type": "application/x-www-form-urlencoded", "Cache-Control": "no-cache"]
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
                theRequest.httpBody = dataBody
            }
            else if contentType == .RAW {
                var headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache"
                ]
                if useToken! {
                    headers = [
                        "content-type": "application/json",
                        "cache-control": "no-cache",
                        "accesstoken" : SharedModel.getToken(),
                        "devicetype" : "3"
                    ]
                }
                
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
            }else{
                let url : URL? = URL.init(string: ("\(API_ROOT)\(methodName)") + queryItems(dictionary:  parameters as [String : Any]))
                theRequest = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 180)
                theRequest.httpMethod = stMethodType
            }
            
            break
            
        case .POST:
            stMethodType = "POST"
            var stData: String = ""
            var i: Int = 0
            for (pKey, pvalue) in dictParameters {
                if pvalue is String {
                    stData = "\(pKey)=\((pvalue as! String).addingPercentEncodingForQueryParameter()!)"
                    stData = i == 0 ? stData : "&\(stData)"
                    dataBody.append(stData.data(using: .utf8)!)
                    i += 1
                }
            }
            if contentType == .FORM_DATA { //FORM_DATA
                theRequest = URLRequest(url: URL(string: API_ROOT + "\(methodName)")!)
                theRequest.httpMethod = stMethodType
                let boundary = generateBoundary()
                var headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache",
                ]
                if useToken! {
                    headers = [
                        "content-type": "application/json",
                        "cache-control": "no-cache",
                        "accesstoken" : SharedModel.getToken(),
                        "devicetype" : "3"
                    ]
                }
                
                theRequest.allHTTPHeaderFields = headers
                theRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                let dataBody = createDataBody(withParameters: dictParameters, boundary: boundary)
                
                theRequest.httpBody = dataBody
                
            }else if contentType == .X_WWW_FORM { //X_WWW_FORM
                let headers = ["content-type": "application/x-www-form-urlencoded", "Cache-Control": "no-cache"]
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
                theRequest.httpBody = dataBody
            }
            else if contentType == .RAW {  // RAW
                let params = dictParameters
                //  for (pKey, pvalue) in params { params[pKey] = self.getcodeforkeys(pvalue)}
                var headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache",
                ]
                if useToken! {
                    headers = [
                        "content-type": "application/json",
                        "cache-control": "no-cache",
                        "accesstoken" : SharedModel.getToken(),
                        "devicetype" : "3"
                    ]
                }
              print("HEADER TOEKN : ", headers)
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
                let stPostData = params.convertToJSonString()
                theRequest.httpBody = stPostData.data(using: .utf8)
            }else{
                let url : URL? = URL.init(string: ("\(API_ROOT)\(methodName)") + queryItems(dictionary:  parameters as [String : Any]))
                theRequest = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 180)
                theRequest.httpMethod = stMethodType
            }
            break
        case .PUT:
            stMethodType = "PUT"
            if contentType == .RAW {  // RAW
                let params = dictParameters
                //  for (pKey, pvalue) in params { params[pKey] = self.getcodeforkeys(pvalue)}
                var headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache",
                ]
                if useToken! {
                    headers = [
                        "content-type": "application/json",
                        "cache-control": "no-cache",
                        "accesstoken" : SharedModel.getToken(),
                        "devicetype" : "3"
                    ]
                }
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
                let stPostData = params.convertToJSonString()
                theRequest.httpBody = stPostData.data(using: .utf8)
            }
        case .DELETE:
            stMethodType = "DELETE"
            if contentType == .RAW {  // RAW
                let params = dictParameters
                //  for (pKey, pvalue) in params { params[pKey] = self.getcodeforkeys(pvalue)}
                var headers = [
                    "content-type": "application/json",
                    "cache-control": "no-cache",
                ]
                if useToken! {
                    headers = [
                        "content-type": "application/json",
                        "cache-control": "no-cache",
                        "accesstoken" : SharedModel.getToken(),
                        "devicetype" : "3"
                    ]
                }
                theRequest = URLRequest(url: URL(string: "\(API_ROOT)\(methodName)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
                theRequest.httpMethod = stMethodType
                theRequest.allHTTPHeaderFields = headers
                let stPostData = params.convertToJSonString()
                theRequest.httpBody = stPostData.data(using: .utf8)
            }
        }
        
        dLog(message: " THE REQUEST:\(String(describing: theRequest))")
        
        let dataTask = URLSession.shared.dataTask(with: theRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            DispatchQueue.main.async(execute: {
                if showLoding { hideLoder() }
                var dictServiceData = typeAliasDictionary()
                if (error != nil) {
                    print(error as Any)
                } else {
                    let stData: String = String(data: data!, encoding: .utf8)!
                    
                    dictServiceData = stData.convertToDictionary() as typeAliasDictionary
                    
                    if !dictServiceData.isEmpty {
                        dLog(message: dictServiceData)
                    }
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if httpResponse.statusCode == 200 {
                        onCompletion(dictServiceData)
                    } else if httpResponse.statusCode == 400 {
                        showAlertWithTitle(message: dictServiceData.valuForKeyString("message"), type: .WARNING)
                    } else if httpResponse.statusCode == 401 {
                        appDelegateObject().showLogin()
                    }
                }
            })
        })
        
        dataTask.resume()
        
    }else{
        if showLoding { hideLoder() }
        
        let actionMenuView :  NoInterNet = UIView.fromNib()
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.showPopUp(popupView: actionMenuView, gravity: .Top, isBackClickDismiss:false)
        }
        
        actionMenuView.btnTryAgain.block_setAction { (click) in
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.dismissMaskView()
            }
            callRestApi(methodName, methodType: methodType, parameters: parameters, contentType: contentType, showLoding: showLoding,useToken: useToken, onCompletion: { (responce) in
                onCompletion(responce)
            })
        }
    }
    
}
func getReplaceCodeForKeys(_ stCode: String) -> String {
    var st_CodeNew: String = stCode
    st_CodeNew = st_CodeNew.replace("&", withString: "&amp;")
    st_CodeNew = st_CodeNew.replace("<", withString: "&lt;")
    st_CodeNew = st_CodeNew.replace(">", withString: "&gt;")
    st_CodeNew = st_CodeNew.replace("'", withString: "&apos;")
    st_CodeNew = st_CodeNew.replace("\"", withString: "&quot;")
    return st_CodeNew
}
func queryItems(dictionary: [String:Any]) -> String {
    var components = URLComponents()
    components.queryItems = dictionary.map {
        URLQueryItem(name: $0, value: ($1  as! String))
    }
    return (components.url?.absoluteString)!
}
//MARK:- Rest method privet Funcations
func generateBoundary() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}
func createDataBody(withParameters params: typeAliasDictionary?, boundary: String) -> Data {
    
    let lineBreak = "\r\n"
    var body = Data()
    
    if let parameters = params {
        for (key, value) in parameters {
            
            
            if value is Data  {
                body.append(("--\(boundary + lineBreak)").data(using: .utf8)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"").data(using: .utf8)!)
                body += ";filename=\"\(key).jpeg\"\r\n".data(using: .utf8)!
                body += "Content-Type: image/jpg \r\n\r\n".data(using: .utf8)!
                body += value as! Data
                body += lineBreak.data(using: .utf8)!
            }
            else {
                body.append(("--\(boundary + lineBreak)").data(using: .utf8)!)
                body.append(("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)").data(using: .utf8)!)
                body.append(("\((value as! String) + lineBreak)").data(using: .utf8)!)
            }
        }
        //body.append(("--\(boundary + lineBreak)").data(using: .utf8)!)
        
    }
    
    body.append(("--\(boundary + lineBreak)").data(using: .utf8)!)
    
    return body
}


enum METHOD_TYPE: Int {
    case GET
    case POST
    case PUT
    case DELETE
}

enum CONTENT_TYPE:Int {
    case DUMMY
    case FORM_DATA
    case X_WWW_FORM
    case RAW
}
