//
//  PageViewController.m
//  Imgur
//
//  Created by almas daumov on 11/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import "XMLReader.h"

@implementation PageViewController
@synthesize imageView = _imageView;
@synthesize nextImageButton = _nextImageButton;
@synthesize previousImageButton = _previousImageButton;
@synthesize imageTitle = _imageTitle;
@synthesize webView = _webView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageNumber = 0;
    
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/gallery/page/0.xml"];
    NSString *xmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    // Parse the XML into an array
    XMLReader *reader = [[XMLReader alloc] initWithError:NULL];
    _pageData = (NSMutableArray *)[reader objectWithData:[xmlString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Initiate the first picture download
    _imageData = [[NSMutableData alloc] init];
    NSString *imageUrlString = [[NSString alloc] initWithFormat:@"http://i.imgur.com/%@.jpg", [[_pageData objectAtIndex:_imageNumber] valueForKey:@"hash"]];
    NSLog(@"%@", imageUrlString);
    [self.imageTitle setText:[NSString stringWithFormat:@"%@", [[_pageData objectAtIndex:_imageNumber] valueForKey:@"title"]]];
    NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
//    [self.webView loadRequest:request];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    [_pageData retain];
    [imageUrlString release];
    [reader release];
}



- (IBAction)nextImageButtonTapped:(id)sender {
    // Disable buttons while image is loading
    self.previousImageButton.enabled = NO;
    self.nextImageButton.enabled = NO;
    
    
    if ([[[sender titleLabel] text] isEqual:@"Previous"]) _imageNumber--;
    else _imageNumber++;
    if (_imageNumber < [_pageData count]) {
        NSLog(@"imageNumber %d", _imageNumber);
        NSString *imageUrlString = [[NSString alloc] initWithFormat:@"http://i.imgur.com/%@.jpg", [[_pageData objectAtIndex:_imageNumber] valueForKey:@"hash"]];
        NSLog(@"%@", imageUrlString);
        [self.imageTitle setText:[NSString stringWithFormat:@"%@", [[_pageData objectAtIndex:_imageNumber] valueForKey:@"title"]]];
        NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        _imageData = [[NSMutableData alloc] init];
        [connection start];
    }
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


#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dt {
	[_imageData appendData:dt];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"connection:didFinishLoading %d bytes", [_imageData length]);
	
    // Set the image to the imageView
	_image = [UIImage imageWithData:_imageData];
	[self.imageView setImage:_image];
    
    
    // Enable buttons once the image is downloaded
    self.previousImageButton.enabled = YES;
    self.nextImageButton.enabled = YES;
    
    [_imageData release];
    
}

@end
