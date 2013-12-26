//
//  hairStyleCategory.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-24.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hairStyleCategory : NSObject
{

}
@property(nonatomic,strong)NSArray * firstArray;
@property(nonatomic,strong)NSArray * secondArray;
@property(nonatomic,strong)NSArray * thirdArray;
@property(nonatomic,strong)NSArray * forthArray;
@property(nonatomic,strong)NSArray * fifthArray;
@property(nonatomic,strong)NSArray * sixthArray;

+(hairStyleCategory *)shareData;
@end
