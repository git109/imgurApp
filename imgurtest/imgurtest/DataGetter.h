//
//  DataGetter.h
//  imgurApp
//
//  Created by almas daumov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataGetter : NSObject 

+ (NSArray *)getHotForPage:(int)pageNumber;
+ (NSArray *)getTopWeekForPage:(int)pageNumber;
+ (NSArray *)getTopMonthForPage:(int)pageNumber;
+ (NSArray *)getTopAllForPage:(int)pageNumber;



@end
