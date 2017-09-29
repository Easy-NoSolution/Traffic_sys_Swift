//
//  NetworkTools.swift
//  Traffic_sys_Swift
//
//  Created by 易无解 on 22/09/2017.
//  Copyright © 2017 易无解. All rights reserved.
//

import AFNetworking

enum RequestType: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTools: AFHTTPSessionManager {
    
    static let shareInstance : NetworkTools = {
        let tools = NetworkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
}

// MARK: - 封装请求方法
extension NetworkTools {
    func request(methodType: RequestType, urlString: String, parameters: [String : AnyObject], finished: @escaping (_ result: Any?, _ error: Error?) -> ()) {
//        发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: { (task, response) in
                finished(response, nil)
            }, failure: { (task, error) in
                finished(nil, error)
            })
        } else {
            post(urlString, parameters: parameters, progress: nil, success: { (task, response) in
                finished(response, nil)
            }, failure: { (task, error) in
                finished(nil, error)
            })
        }
    }
}

// MARK: - 注册用户
extension NetworkTools {
    func registerUserInfo(userId: String, username: String, userSex: NSInteger, userBirthday: Date?, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取请求的URLString
        let urlString = "http://39.108.237.44/traffic_sys/register.php"
        print(urlString)
//        2.获取请求的参数
        guard let userBirthday = userBirthday else {
            return
        }
        
        let parameters = ["userId" : userId, "username" : username, "userSex" : userSex, "userBirthday" : userBirthday, "password" : password] as [String : AnyObject]
        print(parameters)
//        3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters) { (response, error) in
//            3.1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            3.2.将数组数据回调给外界控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 注册用户并携带头像

extension NetworkTools {

    func registerUserInfo(userId: String, username: String, userSex: NSInteger, userBirthday: Date?, userAvatar: UIImage?, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取请求的URLString
        let urlString = "http://39.108.237.44/traffic_sys/register.php"
        print(urlString)
        
//        2.获取请求的参数
        guard let userBirthday = userBirthday else {
            return
        }
        guard let userAvatar = userAvatar else {
            return
        }
        let parameters = ["userId" : userId, "username" : username, "userSex" : userSex, "userBirthday" : userBirthday, "userAvatar" : userAvatar, "password" : password] as [String : AnyObject]

//        3.发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            if let userAvatarData = UIImagePNGRepresentation(userAvatar) {
                formData.appendPart(withFileData: userAvatarData, name: "userAvatar", fileName: "userAvatar.png", mimeType: "image/png")
            }
        }, progress: nil, success: { (task, response) in
//            获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                return
            }
            
//            将请求结果回调给外界控制器
            finished(responseDict, nil)
        }) { (task, error) in
//            将数据回调给外界控制器
            finished(nil, error)
        }
    }
}

// MARK: - 登录账户
extension NetworkTools {
    func login(userId: String, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取请求的URLString
        let urlString = "http://39.108.237.44/traffic_sys/login.php"
        print(urlString)
        
//        2.获取请求的参数
        let parameters = ["userId" : userId, "password" : password] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters) { (response, error) in
            
//            3.1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            3.2.将数组数据回调给外界控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 修改密码
extension NetworkTools {
    func modifyPassword(userId: String, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取URLString
        let urlString = "http://39.108.237.44/traffic_sys/modifyPassword.php"
        
//        2.获取请求参数
        let parameters = ["userId" : userId, "password" : password] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters) { (response, error) in
            
//            3.1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            3.2.将数据回调给外界控制器
            finished(responseDict, error)
        }
    }
}
