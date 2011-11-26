//
//  GalleryPagesController.h
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryPagesController : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
    
    // Image Views
    IBOutlet UIImageView *_image1;
    IBOutlet UIImageView *_image2;
    IBOutlet UIImageView *_image3;
    IBOutlet UIImageView *_image4;
    IBOutlet UIImageView *_image5;
    IBOutlet UIImageView *_image6;
    IBOutlet UIImageView *_image7;
    IBOutlet UIImageView *_image8;
    IBOutlet UIImageView *_image9;

}
@property (strong, nonatomic) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

@end
