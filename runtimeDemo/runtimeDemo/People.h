//
//  People.h
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,copy) NSString *occupation;//职业
@property (nonatomic,copy) NSString *nationality;//国籍

- (void)sing;

@end
