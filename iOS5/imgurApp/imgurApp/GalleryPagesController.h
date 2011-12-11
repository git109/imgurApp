//
//  GalleryPagesController.h
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageViewController.h"
#import "dispatch/dispatch.h"


@interface GalleryPagesController : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
    NSArray *pagesData;
    NSData *_imageData;
    
    IBOutlet UIButton *_button1;
    IBOutlet UIButton *_button2;
    IBOutlet UIButton *_button3;
    IBOutlet UIButton *_button4;
    IBOutlet UIButton *_button5;
    IBOutlet UIButton *_button6;
    IBOutlet UIButton *_button7;
    IBOutlet UIButton *_button8;
    IBOutlet UIButton *_button9;
    NSMutableArray *_arrayOfButtons;
    
    
    ImageViewController *imageController;
    
    dispatch_queue_t backgroundQueue;

}
@property (strong, nonatomic) UILabel *pageNumberLabel;
@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) ImageViewController *imageController;



- (id)initWithPageNumber:(int)page andData:(NSArray *)data;

- (IBAction)imageSelected:(NSArray *)pagesData;

@end
