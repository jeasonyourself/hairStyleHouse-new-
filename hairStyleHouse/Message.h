//
//  Message.h
//  TableViewChatDemo
//
//  Created by Rannie on 13-9-9.
//  Copyright (c) 2013年 Rannie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (strong, nonatomic) NSString *msg;
@property (assign, nonatomic, getter = isMine) BOOL mine;
@end
