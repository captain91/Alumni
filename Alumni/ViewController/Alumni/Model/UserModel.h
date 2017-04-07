//
//  UserModel.h
//  Alumni
//
//  Created by Sun on 2017/2/11.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *snoStr;
@property (nonatomic, copy) NSString *snameStr;
@property (nonatomic, copy) NSString *sageStr;
@property (nonatomic, copy) NSString *ssexStr;
@property (nonatomic, copy) NSString *sbirthdayStr;
@property (nonatomic, copy) NSString *sphonenumberStr;
@property (nonatomic, copy) NSString *scityStr;
@property (nonatomic, copy) NSString *smarriageStr;
@property (nonatomic, copy) NSString *sheadimageurlStr;

- (id)initDataModelWithDictionary:(NSDictionary *)dict;
//测试
@property (nonatomic, copy) NSString *userNameStr;
@property (nonatomic, copy) NSString *userIconStr;

//图片高度
@property (nonatomic) float photoH;
@end
