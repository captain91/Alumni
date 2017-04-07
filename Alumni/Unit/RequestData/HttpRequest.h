//
//  RequestData.h
//  TopMaster
//
//  Created by Sun on 16/8/9.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HttpRequest : NSObject

/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param succeed 成功回调
 *  @param failure    失败回调
 */
+ (NSURLSessionDataTask *)GET:(NSString *)url
            params:(NSDictionary *)params
                succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
                failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;


/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param succeed 成功回调
 *  @param failure    失败回调
 */
+(NSURLSessionDataTask *)POST:(NSString *)url
        params:(NSDictionary *)params
            succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
            failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param succeed  成功回调
 *  @param failure     失败回调
 */
+(NSURLSessionDataTask *)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(void(^)(NSProgress *progress))progress
             succeed:(void(^)(NSURLSessionDataTask *task,id responseObject))succeed
             failure:(void(^)(NSURLSessionDataTask *task,NSError *error))failure;

@end
