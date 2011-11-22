//
//  ImgurAppDelegate.h
//  Imgur
//
//  Created by almas daumov on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"

@interface ImgurAppDelegate : NSObject <UIApplicationDelegate> {
    IBOutlet PageViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PageViewController *viewController;

@end
