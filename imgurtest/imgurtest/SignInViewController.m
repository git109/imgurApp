//
//  FirstViewController.m
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SignInViewController.h"
#import "GTMOAuthAuthentication.h"
#import "GTMOAuthViewControllerTouch.h"

static NSString *CONSUMER_KEY = @"34b8306684dd5e093fd5a28d4efd45fe04f020cd3";
static NSString *CONSUMER_SECRET =  @"117715f869e84cb354e2db40ab0158ce";
static NSString *SERVICE_PROVIDER = @"ImgurService";

@implementation SignInViewController

@synthesize SignInLabel;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setSignInLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (GTMOAuthAuthentication *)imgurAuth {
    GTMOAuthAuthentication *auth;
    auth = [[GTMOAuthAuthentication alloc] initWithSignatureMethod:kGTMOAuthSignatureMethodHMAC_SHA1 consumerKey:CONSUMER_KEY privateKey:CONSUMER_SECRET];
    
    // setting the service name lets us inspect the auth object later to know what service it is for
    auth.serviceProvider = SERVICE_PROVIDER;
    
    return auth;
}

- (void)signInToImgurService {
    
    NSURL *requestURL = [NSURL URLWithString:@"https://api.imgur.com/oauth/request_token"];
    NSURL *authorizeURL = [NSURL URLWithString:@"https://api.imgur.com/oauth/authorize"];
    NSURL *accessURL = [NSURL URLWithString:@"https://api.imgur.com/oauth/access_token"];
    NSString *scope = @"https://api.imgur.com/";
    
    GTMOAuthAuthentication *auth = [self imgurAuth];
    
    // set the callback URL to which the site should redirect and for which
    // the OAuth controller shoul dlook to determine when the sign in has
    // finished or been canceled
    
    // This URL does not need to be for an actual web page
    [auth setCallback:@"http://www.imgur.com/OAuthCallback"];
    
    // Display the authentication view
    GTMOAuthViewControllerTouch *viewController;
    viewController = [[GTMOAuthViewControllerTouch alloc] initWithScope:scope language:nil requestTokenURL:requestURL authorizeTokenURL:authorizeURL accessTokenURL:accessURL authentication:auth appServiceName:@"Imgur App: Imgur Service" delegate:self finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController animated:YES];
    
}

- (void)viewController:(GTMOAuthViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuthAuthentication *)auth
                 error:(NSError *)error {
    if (error != nil) {
        // Auth failed        
        NSLog(@"*****Auth Failed*****");
    } else {
        // Auth succeeded
        NSLog(@"*****Auth Successful*****");
        self.SignInLabel.title = @"Signed In";
    }
    
}

- (IBAction)SignIn:(id)sender {
    [self signInToImgurService];
}

@end
