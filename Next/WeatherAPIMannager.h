//
//  WeatherAPIMannager.h
//  Next
//
//  Created by JoLi on 2015-02-25.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

@class Weather;

@interface WeatherAPIMannager : AFHTTPSessionManager

+ (WeatherAPIMannager *)sharedInstance;

// completion handler is always called on the main thread
- (void)getWheatherDescriptionForLocation:(CLLocation *)location completion:(void (^)(Weather *))completion;

@end
