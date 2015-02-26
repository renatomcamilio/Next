//
//  Weather.h
//  Next
//
//  Created by JoLi on 2015-02-25.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, strong) NSString *mainDescription;
@property (nonatomic, strong) NSString *detailDescription;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
