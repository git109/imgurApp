//
//  SecondViewController.h
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    int numberOfScrollViewPages;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;

    
    dispatch_queue_t backgroundQueue;
    
    
    NSArray *pagesData;
    int pageNumber;
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *viewControllers;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *hotButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *topWeekButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *topMonthButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *topAllButton;

- (void)reloadGallery;

- (IBAction)showHot:(id)sender;
- (IBAction)showTopWeek:(id)sender;
- (IBAction)showTopMonth:(id)sender;
- (IBAction)showTopAll:(id)sender;


@end
