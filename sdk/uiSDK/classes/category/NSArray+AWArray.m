//
//  NSArray+AWArray.m
//  AWUI
//
//  Created by yikunHuang on 2021/10/22.
//

#import "NSArray+AWArray.h"

@implementation NSArray (AWArray)

- (id)safe_objectAtIndex:(NSUInteger )index {
    if (index > self.count || index < 0) {
        //index超出数组界限
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
