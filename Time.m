//
//  Time.m
//  Next
//
//  Created by David Manuntag on 2015-02-24.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "Time.h"


@implementation Time


-(NSString*)partOfWeek {
    
    NSString * partOfWeek;
    
    NSDate * day = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSString * dayString = [dateFormatter stringFromDate:day];
    
    
    if ([dayString isEqualToString:@"Friday"]||[dayString isEqualToString:@"Saturday"]||[dayString  isEqualToString:@"Sunday"]) {
        
        partOfWeek=@"Weekend";
        
    }else {
        
      partOfWeek = @"Weekday";
        
    }
    
    return partOfWeek;
    
}

-(NSString*)sectionOfDay {
    
    NSString * timeZone;
    
    NSDate * currentTime = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"HH"];
    
    NSString * timeString = [dateFormatter stringFromDate:currentTime];
    
    NSInteger timeValue = [timeString integerValue];
    
    if (timeValue>5 && timeValue<11) {
        
        timeZone = @"morning";
        
    } else if (timeValue>=11 && timeValue<17) {
        
        timeZone = @"noon";
        
    }else if (timeValue>=17 && timeValue<20) {
        
      timeZone = @"evening";
        
        
    }else if (timeValue>=20 && timeValue<=24){
    
    timeZone = @"lateNight";
    
    }

    return timeZone;
    
}


@end


