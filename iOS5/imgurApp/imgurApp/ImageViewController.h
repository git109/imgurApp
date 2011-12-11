//
//  ImageViewController.h
//  imgurApp
//
//  Created by almas daumov on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController {
    IBOutlet UIButton *backButton;
    
    NSArray *_imagesData;
    
    UIImageView *_imageView;
}
@property (strong, nonatomic) NSArray *imagesData;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)clickMe:(id)sender;

@end
