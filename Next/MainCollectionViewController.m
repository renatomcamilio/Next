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

@interface MainCollectionViewController ()
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSMutableArray *fourSquareObjects;

@end

@implementation MainCollectionViewController 

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LocationManager sharedInstance] startUpdatingLocation];
    
     self.fourSquareObjects = [NSMutableArray array];
    
    [[WeatherAPIMannager sharedInstance] getWheatherDescriptionForLocation:[LocationManager sharedInstance].currentLocation completion:^(Weather *weather) {
        
        self.currentWeather = weather;
        
        NSLog(@"newWeather: %@, description: %@", self.currentWeather.mainDescription , self.currentWeather.detailDescription);
        
        SugestionCalculator * sugestionCalculator = [[SugestionCalculator alloc]init];
        NSString * partOfWeek = [Time partOfWeek];
        NSString * sectionOfDay = [Time sectionOfDay];
        
        [sugestionCalculator calculateReccomendationArray:partOfWeek sectionOfDay:sectionOfDay mainWeather:self.currentWeather.mainDescription];
        NSLog(@"%@", self.currentWeather.mainDescription);
        
        NSString * randomReccomendation = [sugestionCalculator randomRecomendedSection];
        NSLog(@"Foursquare section: %@", randomReccomendation);
        
        // first foursquare object
//        FourSquareApiManager * foursquareApiManager= [FourSquareApiManager sharedInstance];
//        [foursquareApiManager getFoursquareObjectWithLocation:[LocationManager sharedInstance].currentLocation randomReccomendation:randomReccomendation completion:^(FoursquareObject *fourSquareObject) {
//            
//            [self.fourSquareObjects addObject:fourSquareObject];
//            NSLog(@"%@", self.fourSquareObjects);
////            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.collectionView reloadData];
////            });
//
//        }];
        
    }];
    
    for (int i = 0 ; i<10 ; i++) {
        [self performSelector:@selector(loadFoursquareObjects) withObject:self afterDelay:5.0];
    }

//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}


-(void)loadFoursquareObjects {
    
    SugestionCalculator * sugestionCalculator = [[SugestionCalculator alloc]init];
    NSString * partOfWeek = [Time partOfWeek];
    NSString * sectionOfDay = [Time sectionOfDay];
    
    [sugestionCalculator calculateReccomendationArray:partOfWeek sectionOfDay:sectionOfDay mainWeather:self.currentWeather.mainDescription];
    NSLog(@"%@", self.currentWeather.mainDescription);
    
    NSString * randomReccomendation = [sugestionCalculator randomRecomendedSection];
    
    //add foursquare objects to array
    FourSquareApiManager * foursquareApiManager= [FourSquareApiManager sharedInstance];
    [foursquareApiManager getFoursquareObjectWithLocation:[LocationManager sharedInstance].currentLocation randomReccomendation:randomReccomendation completion:^(FoursquareObject *fourSquareObject) {
        
        [self.fourSquareObjects addObject:fourSquareObject];
        NSLog(@"%@", self.fourSquareObjects);
        
        [self.collectionView reloadData];
    }];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.fourSquareObjects.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    FoursquareObject * currentObject = self.fourSquareObjects[indexPath.row];
    
    cell.nameLabel.text = currentObject.name;
    cell.shortDescriptionLabel.text = currentObject.shortDescription;
    cell.ratingLabel.text = currentObject.rating;
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *imageUrl = currentObject.photoUrl;
        
        NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = [UIImage imageWithData:imageData];
            //[self.collectionView reloadData];
        });
        
        
    });
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
