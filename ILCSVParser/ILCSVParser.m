//
//  ILCSVParser.m
//  PhysPrac
//
//  Created by Bhumik Sanghavi on 4/5/13.
//  Copyright (c) 2013 Inspeero. All rights reserved.
//

#import "ILCSVParser.h"

@implementation ILCSVParser

- (id) init
{
    self = [super init];
    
    return self;
}
- (void)parseCSVFile:(NSString *)filePath delegate:(id<ILCSVParserDelegate>)delegate
{
    if (!delegate || !filePath) {
        return;
    }
    _delegate = delegate;
    CHCSVParser *parser = [[CHCSVParser alloc]initWithContentsOfCSVFile:filePath];
    
    [parser setDelegate:self];
    [parser parse];
}

#pragma mark CSV delegate

- (void)parserDidBeginDocument:(CHCSVParser *)parser
{
    //Alloc
    _buildArray = [[NSMutableArray alloc]init];
}

- (void)parserDidEndDocument:(CHCSVParser *)parser
{
    //Called the Success Deleagte
    NSArray *resultArray = [_buildArray copy];
    
    //Clear BuildArray
    [_buildArray removeAllObjects];
    _buildArray = nil;
    
    [_delegate parsingDidFinish:resultArray];
    
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    _lineDictionary = [[NSMutableDictionary alloc]init];
    
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber
{
    [_buildArray addObject:_lineDictionary];
    
    //[_lineDictionary release];
    _lineDictionary = nil;
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex;
{
    [_lineDictionary setObject:field forKey:[NSNumber numberWithInteger:fieldIndex+1]];
}

- (void)parser:(CHCSVParser *)parser didReadComment:(NSString *)comment
{
    return;
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error;
{
    [_delegate parsingFailed];
}



@end
