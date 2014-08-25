//
//  ILCSVParser.h
//  PhysPrac
//
//  Created by Bhumik Sanghavi on 4/5/13.
//  Copyright (c) 2013 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CHCSVParser.h"

@protocol ILCSVParserDelegate <NSObject>

@required
- (void) parsingDidFinish:(NSArray *)parseObjects;
-(void) parsingFailed;
@end

@interface ILCSVParser : NSObject <CHCSVParserDelegate>
{
    NSMutableArray *_buildArray;
    NSMutableDictionary *_lineDictionary;
    id _delegate;
}

- (void) parseCSVFile:(NSString *)filePath delegate:(id<ILCSVParserDelegate>)delegate;
@end

