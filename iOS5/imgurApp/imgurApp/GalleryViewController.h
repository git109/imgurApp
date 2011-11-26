//
//  GalleryViewController.h
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryPagesController.h"

@interface GalleryViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    int numberOfPages;
    
    NSArray *pagesData;
    
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;

- (void)loadScrollViewWithPage:(int)page;

- (NSMutableArray *)getDataForGalleryPage:(int)page;



@end
