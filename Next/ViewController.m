//
//  ViewController.m
//  Next
//
//  Created by JoLi on 2015-02-24.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import "WeatherAPIMannager.h"
#import "Weather.h"
#import "SugestionCalculator.h"
#import "Time.h"
#import "FourSquareApiManager.h"

@interface ViewController ()
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSMutableArray *fourSquareObjects;

@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, strong) WeatherAPIMannager *weatherManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test
    self.locationManager = [LocationManager sharedInstance];
    [self.locationManager startUpdatingLocation];
    
    self.weatherManager = [WeatherAPIMannager sharedInstance];
    
    
    [self.weatherManager getWheatherDescriptionForLocation:self.locationManager.currentLocation completion:^(Weather *weather) {
        self.currentWeather = weather;
        NSLog(@"main: %@, description: %@", self.currentWeather.mainDescription, self.currentWeather.detailDescription);
    }];
    
    
    
    
    self.fourSquareObjects = [NSMutableArray array];
    
     
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)weatherTest:(id)sender {
    
    SugestionCalculator * sugestionCalculator = [[SugestionCalculator alloc]init];
    NSString * partOfWeek = [Time partOfWeek];
    NSString * sectionOfDay = [Time sectionOfDay];
    
    [sugestionCalculator calculateReccomendationArray:partOfWeek sectionOfDay:sectionOfDay mainWeather:self.currentWeather.mainDescription];
    NSLog(@"%@", self.currentWeather.mainDescription); 
    
    NSString * randomReccomendation = [sugestionCalculator randomRecomendedSection];
    
    self.descriptionLabel.text = randomReccomendation;
    
    
    //foursquare api test
    
    FourSquareApiManager * foursquareApiManager= [FourSquareApiManager sharedInstance];
    [foursquareApiManager getFoursquareObjectWithLocation:self.locationManager.currentLocation randomReccomendation:randomReccomendation completion:^(FoursquareObject *fourSquareObject) {
        
        [self.fourSquareObjects addObject:fourSquareObject];
        NSLog(@"%@", self.fourSquareObjects);
    }];
    
    
    

    

}
@end
