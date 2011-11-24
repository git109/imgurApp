//
//  RootViewController.h
//  Imgur
//
//  Created by almas daumov on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryViewController.h"

@interface RootViewController : UIViewController {
    GalleryViewController *galleryController;
}

@property (nonatomic, retain) GalleryViewController *galleryController;


- (IBAction)goToGallery:(id)sender;


@end
