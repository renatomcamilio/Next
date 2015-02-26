//
//  Weather.m
//  Next
//
//  Created by JoLi on 2015-02-25.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.mainDescription = dictionary[@"main"];
        self.detailDescription = dictionary[@"description"];
    }
    return self;
}

@end
