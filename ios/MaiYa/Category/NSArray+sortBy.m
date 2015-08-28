//
//  NSArray+sortBy.m
//  xiche
//
//  Created by zxl on 15/6/16.
//  Copyright (c) 2015年 CX-WX. All rights reserved.
//

#import "NSArray+sortBy.h"

@implementation NSArray (sortBy)

- (NSArray*) sortByObjectTag {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return ([obj1 tag] < [obj2 tag]) ? NSOrderedAscending : ([obj1 tag] > [obj2 tag]) ? NSOrderedDescending : NSOrderedSame;
    }];
}

- (NSArray*) sortByUIViewOriginX {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return( ([objA frame].origin.x < [objB frame].origin.x) ? NSOrderedAscending : ([objA frame].origin.x > [objB frame].origin.x) ? NSOrderedDescending : NSOrderedSame);
    }];
}

- (NSArray*) sortByUIViewOriginY {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return( ([objA frame].origin.y < [objB frame].origin.y) ? NSOrderedAscending : ([objA frame].origin.y > [objB frame].origin.y) ? NSOrderedDescending : NSOrderedSame);
    }];
}

@end
