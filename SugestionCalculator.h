//
//  SugestionCalculator.h
//  Next
//
//  Created by David Manuntag on 2015-02-25.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SugestionCalculator : NSObject

-(NSString*)calculateReccomendationSection:(NSString*)partOfWeek sectionOfDay:(NSString*)sectionOfDay currentWeather:(NSString*)currentWeather;


@end
