//
//  UserModel.m
//  Alumni
//
//  Created by Sun on 2017/2/11.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (id)initDataModelWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        //做判空处理，null返回为@"0"
        _snoStr = [FunctionFast objectIsNull:dict[@"sno"]];
        _snameStr = [FunctionFast objectIsNull:dict[@"sname"]];
        _sageStr = [FunctionFast objectIsNull:dict[@"sage"]];
        _ssexStr = [FunctionFast objectIsNull:dict[@"ssex"]];
        _sbirthdayStr = [FunctionFast objectIsNull:dict[@"sbirthday"]];
        _sphonenumberStr = [FunctionFast objectIsNull:dict[@"sphonenumber"]];
        _scityStr = [FunctionFast objectIsNull:dict[@"scity"]];
        _smarriageStr = [FunctionFast objectIsNull:dict[@"smarriage"]];
        _sheadimageurlStr = [FunctionFast objectIsNull:dict[@"sheadimageurl"]];
        
        _userNameStr = [FunctionFast objectIsNull:dict[@"userName"]];
        _userIconStr = [FunctionFast objectIsNull:dict[@"userIcon"]];
    }
    return self;
}
@end
