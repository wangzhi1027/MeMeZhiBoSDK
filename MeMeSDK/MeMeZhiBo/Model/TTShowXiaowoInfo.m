//
//  TTShowXiaowoInfo.m
//  TTShow
//
//  Created by wangyifeng on 15-3-18.
//  Copyright (c) 2015年 twb. All rights reserved.
//

#import "TTShowXiaowoInfo.h"

@implementation TTShowXiaowoInfo

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    

    //NSLog(@"nslog %@",attributes);
    
    if (attributes != nil)
    {
        self._id = [[attributes valueForKey:@"_id"] unsignedIntegerValue];
        self.user_id = [[attributes valueForKey:@"user_id"] unsignedIntegerValue];
        self.m_count = [[attributes valueForKey:@"m_count"] unsignedIntegerValue];
        self.visitor_count = [[attributes valueForKey:@"visitor_count"] unsignedIntegerValue];

        self.timestamp = [[attributes valueForKey:@"timestamp"] longLongValue];
        self.name = [[attributes valueForKey:@"name"] stringByUnescapingFromHTML];
        self.pic = [attributes valueForKey:@"pic"];
        self.notice = [attributes valueForKey:@"notice"];
        self.creator = [attributes valueForKey:@"creator"];
        self.sec_user_info = [attributes valueForKey:@"sec_user_info"];
        self.first_user_info = [attributes valueForKey:@"first_user_info"];
        self.admin = [attributes valueForKey:@"admin"];
        
//        if ([attributes valueForKey:@"mic_first"]) {
//            self.mic_first = [[attributes valueForKey:@"mic_first"] integerValue];
//        }
//        
//        if ([attributes valueForKey:@"mic_sec"]) {
//            self.mic_sec = [[attributes valueForKey:@"mic_sec"] integerValue];
//        }
        
        

    }
    
    return self;
}



-(BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[TTShowXiaowoInfo class]]) {
        TTShowXiaowoInfo *group = object;
        return self._id == group._id;
    }
    return NO;
}

-(NSUInteger)hash
{
    return self._id;
}


@end
