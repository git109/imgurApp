//
//  DataGetter.m
//  imgurApp
//
//  Created by almas daumov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DataGetter.h"
#import "XMLReader.h"

@implementation DataGetter


+ (NSArray *)getHotForPage:(int)pageNumber {
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/hot/page/%d.xml", pageNumber];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *pageData = [XMLReader dictionaryForXMLData:data error:nil];
    return pageData;
}

+ (NSArray *)getTopWeekForPage:(int)pageNumber {
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/top/week/page/%d.xml", pageNumber];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *pageData = [XMLReader dictionaryForXMLData:data error:nil];
    return pageData;
}

+ (NSArray *)getTopMonthForPage:(int)pageNumber {
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/top/month/page/%d.xml", pageNumber];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *pageData = [XMLReader dictionaryForXMLData:data error:nil];
    return pageData;
}

+ (NSArray *)getTopAllForPage:(int)pageNumber {
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/top/all/page/%d.xml", pageNumber];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSArray *pageData = [XMLReader dictionaryForXMLData:data error:nil];
    return pageData;
}




@end
