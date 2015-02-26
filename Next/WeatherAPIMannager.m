//
//  WeatherAPIMannager.m
//  Next
//
//  Created by JoLi on 2015-02-25.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "WeatherAPIMannager.h"
#import "Weather.h"


static NSString *const OpenWeatherBaseURLString = @"http://api.openweathermap.org/data/2.5/";

@implementation WeatherAPIMannager

+ (WeatherAPIMannager *)sharedInstance
{
    static WeatherAPIMannager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:OpenWeatherBaseURLString]];
    });
    
    return  sharedInstance;
}


- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return  self;
}


- (void)getWheatherDescriptionForLocation:(CLLocation *)location completion:(void (^)(Weather *))completion
{
  
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"lat"] = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    parameters[@"lon"] = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    [self GET:@"weather" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
      
        NSDictionary *weatherDetailDictionary = (NSDictionary*)responseObject;
        NSDictionary *weatherDescriptionDictionary = [weatherDetailDictionary[@"weather"] firstObject];
        
        Weather *weather = [[Weather alloc] initWithDictionary:weatherDescriptionDictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(weather);
            }
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error retrieving weather data: %@", error.localizedDescription);
    }];
}



@end
