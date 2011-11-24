//
//  ImgurAppDelegate.h
//  Imgur
//
//  Created by almas daumov on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ImgurAppDelegate : NSObject <UIApplicationDelegate> {
    RootViewController *_rootController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
