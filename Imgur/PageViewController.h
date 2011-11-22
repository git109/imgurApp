//
//  PageViewController.h
//  Imgur
//
//  Created by almas daumov on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Foundation/Foundation.h"

@interface PageViewController : UIViewController {
    
    UIImage        *_image;
    NSMutableArray *_pageData;
    NSMutableData  *_imageData;
    int _imageNumber;
    
    
    // Outlets
    UIImageView *_imageView;
    UITextView  *_imageTitle;
    UIButton    *_nextImageButton;
    UIButton    *_previousImageButton;
    UIWebView   *_webView;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton    *nextImageButton;
@property (nonatomic, retain) IBOutlet UIButton    *previousImageButton;
@property (nonatomic, retain) IBOutlet UITextView  *imageTitle;
@property (nonatomic, retain) IBOutlet UIWebView   *webView;

@end
