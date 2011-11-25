//
//  GalleryPagesController.m
//  Imgur
//
//  Created by almas daumov on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryPagesController.h"

@implementation GalleryPagesController
@synthesize pageNumberLabel;

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"GalleryPagesController" bundle:nil])    {
        pageNumber = page;
    }
    return self;
}

- (void)dealloc {
    [pageNumberLabel release];
    [super dealloc];
}

- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
    self.view.backgroundColor =  [UIColor blackColor];
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
