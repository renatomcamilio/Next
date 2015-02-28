//
//  FourSquareApiManager.m
//  Next
//
//  Created by David Manuntag on 2015-02-26.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "FourSquareApiManager.h"
#import "FoursquareObject.h"

static NSString *const FoursquareBaseURLString = @"https://api.foursquare.com/v2/venues/";
static NSString *const FoursquareClientIDString = @"AEMB5NXEBITYUKAGQLROMYCXWN4PNBHOS0YQXNALWXZDKFJE";
static NSString *const FoursquareClientSecret = @"T3NGIC1CUHA1ZE4BHWG15R14G4ORYGRGLIMAG2VMFQBNZSZW";
static NSString *const FoursquareAPIVersion = @"20140806";
static NSString *const FoursquareRadius = @"10000";
static NSString *const FoursquareLimit =@"5";

@implementation FourSquareApiManager

//v:20140806

+(FourSquareApiManager*)sharedInstance{
    
    static FourSquareApiManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken, ^{
    
        sharedInstance = [[self alloc]initWithBaseURL:[NSURL URLWithString:FoursquareBaseURLString]];
    
    });
    
    return sharedInstance;
    
}

-(instancetype)initWithBaseURL:(NSURL *)url {
    
    if (self = [super initWithBaseURL:url]) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
    }
    return self;
}


-(void)getFoursquareObjectWithLocation:(CLLocation *)location randomReccomendation:(NSString*)randomReccomendation completion:(void (^)(FoursquareObject *))completion{
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = FoursquareClientIDString;
    parameters[@"client_secret"] = FoursquareClientSecret;
    parameters[@"v"] = FoursquareAPIVersion;
    parameters[@"ll"]= [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    parameters[@"section"]= randomReccomendation;
    parameters[@"openNow"]= @1;//Boolean flag to only include venues that are open now
    parameters[@"venuePhotos"]=@1; 
    
    [self GET:@"explore" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary * fourSquareDataDictionary = (NSDictionary*)responseObject;
        NSDictionary *responseDictionary = fourSquareDataDictionary[@"response"];
        
        NSArray *groupsDataArray = responseDictionary[@"groups"];
        NSDictionary * groupsDataDictionary = [groupsDataArray firstObject];
        
        NSArray * itemsDataArray = groupsDataDictionary[@"items"];
        
        
        int randomNumber = arc4random()%[itemsDataArray count];
        NSDictionary *itemDictionary = [itemsDataArray objectAtIndex:randomNumber];
        
        FoursquareObject * fourSquareObject = [[FoursquareObject alloc] initWithDictionary:itemDictionary];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(fourSquareObject);
            }
        });
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", [error userInfo]);
    }];
    
    
    
    
}



@end
