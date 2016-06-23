//
//  People+Associate.m
//  runtimeDemo
//
//  Created by comma on 16/6/23.
//  Copyright © 2016年 lj. All rights reserved.
//

#import "People+Associate.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation People (Associate)

- (void)setAssociatedBust:(NSNumber *)associatedBust
{
    //设置关联对象
    
    objc_setAssociatedObject(self, @selector(associatedBust), associatedBust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)associatedBust
{
    return objc_getAssociatedObject(self, @selector(associatedBust));
}

- (void)setAssociatedCallBack:(CodingCallBack)associatedCallBack
{
    objc_setAssociatedObject(self, @selector(associatedCallBack), associatedCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CodingCallBack)associatedCallBack
{
    return objc_getAssociatedObject(self, @selector(associatedCallBack));
}
@end
