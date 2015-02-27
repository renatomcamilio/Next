//
//  FoursquareObject.m
//  Next
//
//  Created by David Manuntag on 2015-02-26.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "FoursquareObject.h"

@implementation FoursquareObject


-(instancetype)initWithDictionary:(NSDictionary*)dictionary {
    
    
    if (self = [super init]) {
        
        self.name = dictionary[@"venue"][@"name"];
        self.lat = dictionary[@"venue"][@"location"][@"lat"];
        self.lon = dictionary[@"venue"][@"location"][@"lng"];
        
        //short description
        NSArray * shortDescriptionArray = dictionary[@"venue"][@"categories"];
        NSDictionary *shortDescriptionDictionary= [shortDescriptionArray firstObject];
        self.shortDescription = shortDescriptionDictionary[@"shortName"];
    
        self.rating = dictionary[@"venue"][@"rating"];
        self.openingHours = dictionary[@"venue"][@"hours"][@"status"];
        
        //tip
        NSArray *tipArray = dictionary[@"tips"];
        NSDictionary *tipDictionary = [tipArray firstObject];
        self.tip = tipDictionary[@"text"];
        
        //photo
        NSArray * photosGroupArray =dictionary[@"venue"][@"photos"][@"groups"];
        NSDictionary * photosItemsDictionary = [photosGroupArray firstObject];
        NSArray * photoItemsArray =photosItemsDictionary[@"items"];
        
        NSDictionary * photoItemDictionary = [photoItemsArray firstObject];
        
        NSString * photoPrefix = photoItemDictionary[@"prefix"];
        NSString * photoSuffix = photoItemDictionary[@"suffix"];
        NSString * photoResolution = @"300x300";
        NSString * photoUrlString = [NSString stringWithFormat:@"%@%@%@", photoPrefix,photoResolution,photoSuffix];
        self.photoUrl = [NSURL URLWithString:photoUrlString];
        
    }
    return self;
}


@end
