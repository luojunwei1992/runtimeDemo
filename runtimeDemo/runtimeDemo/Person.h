//
//  Person.h
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) NSNumber *age;

@property (nonatomic,copy) NSString *occupation;

@property (nonatomic,copy) NSString *nationality;


//生成model
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

//转换成字典
- (NSDictionary *)covertToDictionary;

@end
