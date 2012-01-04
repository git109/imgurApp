//
//  FirstViewController.h
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTMOAuthAuthentication.h"
#import "SBJson.h"

@interface SignInViewController: UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *SignInNavigation;
@property (strong, nonatomic) GTMOAuthAuthentication *authentication;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *SignInOutButton;
@property (weak, nonatomic) IBOutlet UILabel *SignInLabel;
@property (strong, nonatomic) SBJsonParser *parser;
@property (strong, nonatomic) SBJsonWriter *writer;

- (IBAction)SignInOut:(id)sender;
- (GTMOAuthAuthentication *)imgurAuth;

@end
