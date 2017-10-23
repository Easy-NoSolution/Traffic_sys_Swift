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
    func registerUserInfo(userId: String, username: String, userSex: NSInteger, userBirthday: String?, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取请求的URLString
        let urlString = "http://39.108.237.44/traffic_sys/register.php"
        
//        2.获取请求的参数
        guard let userBirthday = userBirthday else {
            return
        }
        
        let parameters = ["userId" : userId, "username" : username, "userSex" : userSex, "userBirthday" : userBirthday, "password" : password] as [String : AnyObject]
        
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

    func registerUserInfo(userId: String, username: String, userSex: NSInteger, userBirthday: String?, userAvatar: UIImage?, password: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取请求的URLString
        let urlString = "http://39.108.237.44/traffic_sys/register.php"
        
//        2.获取请求的参数
        guard let userBirthday = userBirthday else {
            return
        }
        guard let userAvatar = userAvatar else {
            return
        }
        let parameters = ["userId" : userId, "username" : username, "userSex" : userSex, "userBirthday" : userBirthday, "password" : password] as [String : AnyObject]
	
//        3.发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in

            if let userAvatarData = UIImageJPEGRepresentation(userAvatar, 0.1) {
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

// MARK: - 修改个人信息
extension NetworkTools {
    
    func modifyUserInfo(userId: String, username: String, userSex: NSInteger, userBirthday: String?, userAvatar: UIImage?, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取url
        let urlString = "http://39.108.237.44/traffic_sys/modifyUserInfo.php"
        
//        2.获取请求参数
        guard let userBirthday = userBirthday else {
            return
        }
        guard let userAvatar = userAvatar else {
            return
        }
        let parameters = ["userId" : userId, "username" : username, "userSex" : userSex, "userBirthday" : userBirthday] as [String : AnyObject]
        
//        3.发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            if let userAvatarData = UIImageJPEGRepresentation(userAvatar, 0.1) {
                formData.appendPart(withFileData: userAvatarData, name: "userAvatar", fileName: "userAvatar.png", mimeType: "image/png")
            }
        }, progress: nil, success: { (task, response) in
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                return
            }
            
//            2.将请求结果回调给外界控制器
            finished(responseDict, nil)
        }) { (task, error) in
//            1.将请求结果回调给外界控制器
            finished(nil, error)
        }
    }
}

// MARK: - 登录和退出账户记录
extension NetworkTools {
    func addLoginAndLogoutLog(userId: String, loginDate: String?, logoutDate: String?, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/loginLog.php"
        
//        2.获取请求参数
        let parameters = ["userId" : userId, "loginDate" : loginDate, "logoutDate" : logoutDate] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 获取账户登录和退出记录
extension NetworkTools {
    
    func loadLogs(userId: String, offset: NSInteger, rows: NSInteger, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/logData.php"
        
//        2.获取参数
        let parameters = ["userId" : userId, "offset" : offset, "rows" : rows] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 车辆信息登记
extension NetworkTools {
    func carInfoCheckIn(carId: String, carName: String, carColor: String, carOwnerId: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/carInfoCheckIn.php"
        
//        2.获取请求参数
        let parameters = ["carId" : carId, "carName" : carName, "carColor" : carColor, "carOwnerId" : carOwnerId] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 车主信息登记
extension NetworkTools {
    func carOwnerInfoCheckIn(carOwnerId: String, carOwnerName: String, carOwnerSex: NSInteger, carOwnerBirthday: String?, carOwnerAddress: String, carOwnerPhoneNumber: String, carOwnerAvatar: UIImage?, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/carOwnerInfoCheckIn.php"
        
//        2.获取请求参数
        guard let carOwnerBirthday = carOwnerBirthday else {
            return
        }
        guard let carOwnerAvatar = carOwnerAvatar else {
            return
        }
        let parameters = ["carOwnerId" : carOwnerId, "carOwnerName" : carOwnerName, "carOwnerSex" : carOwnerSex, "carOwnerBirthday" : carOwnerBirthday, "carOwnerAddress" : carOwnerAddress, "carOwnerPhoneNumber" : carOwnerPhoneNumber] as [String : AnyObject]
        
//        3.发送网络请求
        post(urlString, parameters: parameters, constructingBodyWith: { (formData) in
            if let carOwnerAvatarData = UIImageJPEGRepresentation(carOwnerAvatar, 0.1) {
                formData.appendPart(withFileData: carOwnerAvatarData, name: "carOwnerAvatar", fileName: "carOwnerAvatar.png", mimeType: "image/png")
            }
        }, progress: nil, success: { (task, response) in
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                return
            }
            
//            2.将请求结果回调给外界控制器
            finished(responseDict, nil)
        }) { (task, error) in
//            1.将请求结果回调给外界控制器
            finished(nil, error)
        }
    }
}

// MARK: - 车辆违规信息登记
extension NetworkTools {
    func lawbreakerInfoCheckIn(carId: String, carOwnerId: String, lawbreakerInfo: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
        
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/lawbreakerInfoCheckIn.php"
        
//        2.获取请求参数
        let parameters = ["carId" : carId, "carOwnerId" : carOwnerId, "lawbreakerInfo" : lawbreakerInfo] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .POST, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 获取车辆信息
extension NetworkTools {
    
    func searchCarInfo(carId: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/searchCarInfo.php"
        
//        2.获取参数
        let parameters = ["carId" : carId] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 获取车主信息
extension NetworkTools {
    
    func searchCarOwnerInfo(carOwnerId: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/searchCarOwnerInfo.php"
        
//        2.获取参数
        let parameters = ["carOwnerId" : carOwnerId] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 通过身份证号获取违规信息
extension NetworkTools {
    
    func searchLawbreakerInfoByIC(carOwnerId: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/searchLawbreakerInfoByIC.php"
        
//        2.获取参数
        let parameters = ["carOwnerId" : carOwnerId] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 通过车牌号获取违规信息
extension NetworkTools {
    
    func searchLawbreakerInfoByCarId(carId: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/searchLawbreakerInfoByCarId.php"
        
//        2.获取参数
        let parameters = ["carId" : carId] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

// MARK: - 通过车牌号获取违规信息
extension NetworkTools {
    
    func searchLawbreakerInfoByCarOwnerName(carOwnerName: String, finished: @escaping (_ response: [String : AnyObject]?, _ error: Error?) -> ()) {
//        1.获取URL
        let urlString = "http://39.108.237.44/traffic_sys/searchLawbreakerInfoByCarOwnerName.php"
        
//        2.获取参数
        let parameters = ["carOwnerName" : carOwnerName] as [String : AnyObject]
        
//        3.发送网络请求
        request(methodType: .GET, urlString: urlString, parameters: parameters) { (response, error) in
            
//            1.获取请求的数据
            guard let responseDict = response as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
//            2.将数据回调给外界的控制器
            finished(responseDict, error)
        }
    }
}

