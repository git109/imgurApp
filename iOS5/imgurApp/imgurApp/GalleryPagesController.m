//
//  GalleryPagesController.m
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryPagesController.h"
#import "ImageViewController.h"

@implementation GalleryPagesController
@synthesize pageNumberLabel;
@synthesize imageData = _imageData;
@synthesize imageController;





- (id)initWithPageNumber:(int)page andData:(NSArray *)data {
    if (self = [super initWithNibName:@"GalleryPagesController" bundle:nil])    {
        pageNumber = page;
        pagesData = data;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (IBAction)imageSelected:(NSArray *)arrayOfImages {
    self.imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
    self.imageController.imagesData = pagesData;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown 
                           forView:self.view.superview.superview cache:YES];
    
    [self.parentViewController presentModalViewController:imageController animated:YES];
//    [self.view.superview.superview addSubview:self.imageController.view];
    
    [UIView commitAnimations];
    

//    self.imageController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
//    self.imageController.imagesData = pagesData;
//    [self.view.superview.superview addSubview:self.imageController.view];
}





- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    _arrayOfButtons = [NSMutableArray arrayWithObjects:_button1, _button2, _button3, _button4, _button5, _button6, _button7, _button8, _button9, nil];
}

- (void)viewDidAppear:(BOOL)animated {
    backgroundQueue = dispatch_queue_create("com.blahblahblah.imgur", NULL);
    
    // Downloading images on the background thread
    dispatch_async(backgroundQueue, ^(void) {
        for (int i=0; i<9; i++) {
            if ((pageNumber*9)+i < [pagesData count]) {
                self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@b.jpg", [[pagesData objectAtIndex:((pageNumber*9)+i)] valueForKey:@"hash"]]]];
                UIImage *image = [UIImage imageWithData:self.imageData];
                // Setting images on the main thread
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    [[_arrayOfButtons objectAtIndex:i] setImage:image forState:UIControlStateNormal];
                    [[_arrayOfButtons objectAtIndex:i] setEnabled:YES];
                });
            }
        }
    });
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}






@end


















