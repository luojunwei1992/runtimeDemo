//
//  People+Associate.h
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "People.h"

typedef void (^CodingCallBack)();

@interface People (Associate)

@property (nonatomic,strong) NSNumber *associatedBust;//胸围

@property (nonatomic,copy)CodingCallBack associatedCallBack; //写代码

@end
