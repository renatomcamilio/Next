//
//  ViewController.m
//  Next
//
//  Created by JoLi on 2015-02-24.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "ViewController.h"
#import "Time.h"

@interface ViewController ()
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) LocationManager *locationManager;
@property (nonatomic, strong) WeatherAPIMannager *weatherManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)weatherTest:(id)sender {
    
//    __weak __typeof(&*self) weakSelf = self;
//    [self.weatherManager getWheatherDescriptionForLocation:self.locationManager.currentLocation completion:^(Weather *weather) {
//        self.currentWeather = weather;
//        self.descriptionLabel.text = self.currentWeather.detailDescription;
//        
//        
//        NSLog(@"main: %@, description: %@", self.currentWeather.mainDescription, self.currentWeather.detailDescription);
//
//    }];
    
    
    
}
@end
