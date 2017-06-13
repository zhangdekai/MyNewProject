//
//  NSString+Language.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/13.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "NSString+Language.h"

@implementation NSString (Language)

- (NSString *)internationalLanguage {
    
    return NSLocalizedString(self, self);
}


@end
