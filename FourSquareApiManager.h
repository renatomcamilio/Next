//
//  FourSquareApiManager.h
//  Next
//
//  Created by David Manuntag on 2015-02-26.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//
#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

@interface FourSquareApiManager : AFHTTPSessionManager

@property (nonatomic, strong) NSDictionary * dictionary;

+(FourSquareApiManager*)sharedInstance;

-(void)getFoursquareObjectWithLocation:(CLLocation *)location randomReccomendation:(NSString*)randomReccomendation;


@end
