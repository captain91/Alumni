//
//  RequestData.m
//  TopMaster
//
//  Created by Sun on 16/8/9.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest
/**
 * 创建网络请求的单例
 */

static HttpRequest *httpRequest = nil;
+ (HttpRequest *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [[self alloc] init];
        }
    });
    return httpRequest;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (httpRequest == nil) {
            httpRequest = [super allocWithZone:zone];
        }
    });
    return httpRequest;
}
-(instancetype)copyWithZone:(NSZone *)zone {
    return httpRequest;
}

/**
 *  封装AFN的GET请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
+ (NSURLSessionDataTask *)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *))failure {
    //创建网络请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 10;
    //发送网络请求
    NSURLSessionDataTask *currentRequst = [manager GET:URLString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        succeed(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return currentRequst;
}

/**
 *  封装AFN的POST请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id))succeed failure:(void (^)(NSError *error))failure
{
    //创建网络请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //申明返回的结果是json类型
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 15;

    //发送网络请求(请求方式为POST)
    NSURLSessionDataTask *currentRequst = [manager POST:URLString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonData = responseObject;
        succeed(jsonData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return currentRequst;
}

#pragma mark - Public
+ (NSURLSessionDataTask *)GET:(NSString *)url
     params:(NSDictionary *)params
    succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
    failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure {
    AFHTTPSessionManager *manager = [HttpRequest managerWithBaseURL:nil sessionConfiguration:NO];
    NSURLSessionDataTask *currentRequst =[manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [HttpRequest responseConfiguration:responseObject];
        succeed(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
    return currentRequst;
}

+(NSURLSessionDataTask *)POST:(NSString *)url
        params:(NSDictionary *)params
            succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
            failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure {
    AFHTTPSessionManager *manager = [HttpRequest managerWithBaseURL:nil sessionConfiguration:NO];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLSessionDataTask *currentRequst =[manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic = [HttpRequest responseConfiguration:responseObject];
        succeed(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    return currentRequst;
}

+(NSURLSessionDataTask *)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(void(^)(NSProgress *progress))progress
             succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
             failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure{
    
    AFHTTPSessionManager *manager = [HttpRequest managerWithBaseURL:nil sessionConfiguration:NO];
    
    NSURLSessionDataTask *currentRequst = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [HttpRequest responseConfiguration:responseObject];
        succeed(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
    return currentRequst;
}

#pragma mark - Private
+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url sessionConfiguration:configuration];
    }else {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 10;
    return manager;
}

+(id)responseConfiguration:(id)responseObject{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        return responseObject;
    }
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
    
}



@end



