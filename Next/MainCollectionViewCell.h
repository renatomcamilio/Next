//
//  MainCollectionViewCell.h
//  Next
//
//  Created by David Manuntag on 2015-02-27.
//  Copyright (c) 2015 Jozef Lipovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@end
