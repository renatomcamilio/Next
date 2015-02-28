//
//  MainCollectionViewController.m
//  Next
//
//  Created by David Manuntag on 2015-02-27.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "LocationManager.h"
#import "WeatherAPIMannager.h"
#import "Weather.h"
#import "SugestionCalculator.h"
#import "Time.h"
#import "FourSquareApiManager.h"
#import "MainCollectionViewCell.h"
#import "FoursquareObject.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MainCollectionViewController ()
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSMutableArray *fourSquareObjects;

@end

@implementation MainCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.fourSquareObjects = [NSMutableArray array];
    
    // Start updating user's current location object
    [[LocationManager sharedInstance] startUpdatingLocation];
    
    // I want to know when the first userLocation object is available, so I can safelly call FourSquare API and Wheather API
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUpdatedLocation)
                                                 name:@"updatedLocation"
                                               object:[LocationManager sharedInstance]];
}

-(void)loadFoursquareObjectsForRandomRecommendation:(NSString *)randomRecommendation {
    //add foursquare objects to array
    FourSquareApiManager * foursquareApiManager= [FourSquareApiManager sharedInstance];
    [foursquareApiManager getFoursquareObjectWithLocation:[LocationManager sharedInstance].currentLocation randomReccomendation:randomRecommendation completion:^(FoursquareObject *fourSquareObject) {
        [self.fourSquareObjects addObject:fourSquareObject];
        
        [self.collectionView reloadData];
    }];
}

- (void)handleRandomRecommendation {
    NSString * partOfWeek = [Time partOfWeek];
    NSString * sectionOfDay = [Time sectionOfDay];
    
    SugestionCalculator * sugestionCalculator = [[SugestionCalculator alloc] init];
    [sugestionCalculator calculateReccomendationArray:partOfWeek sectionOfDay:sectionOfDay mainWeather:self.currentWeather.detailDescription];
    
    NSString *randomReccomendation = [sugestionCalculator randomRecomendedSection];
    
    [self loadFoursquareObjectsForRandomRecommendation:randomReccomendation];
}

- (void)handleUpdatedLocation {
    // Remove handler so it stops calling for updates
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Now that I know the updated user location, I'll get the wheather info
    [[WeatherAPIMannager sharedInstance]
     getWheatherDescriptionForLocation:[LocationManager sharedInstance].currentLocation // Here I'm sure that now it has something there
     completion:^(Weather *weather) {
         self.currentWeather = weather;

         [self handleRandomRecommendation];
     }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fourSquareObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    FoursquareObject *currentObject = self.fourSquareObjects[indexPath.row];
    
    cell.nameLabel.text = currentObject.name;
    cell.shortDescriptionLabel.text = currentObject.shortDescription;
    cell.ratingLabel.text = [currentObject.rating stringValue];
    
    // This code does exactly the same as the commented code down there
    [cell.imageView setImageWithURL:currentObject.photoUrl];
    
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL *imageUrl = currentObject.photoUrl;
//        
//        NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            cell.imageView.image = [UIImage imageWithData:imageData];
//            //[self.collectionView reloadData];
//        });
//        
//        
//    });
    
    return cell;
}

@end
