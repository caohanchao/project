//
//  NoticeModel.m
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "NoticeModel.h"
#import <UIKit/UIKit.h>


@implementation TipList

@end

@implementation NoticeList

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
        @"ID" : @"id"
    }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    if(self = [super initWithDictionary:dict error:err]){
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: [dict[@"postTime"] integerValue]/1000];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
        self.postTime =  [formatter stringFromDate: date];
    }
    return self;
}

@end

@interface NoticeModel ()

@property(nonatomic, strong) UILabel<Ignore> *calculationHelper;

@end

@implementation NoticeModel

// MARK: Methods that calculates NotificationCell->TiplistView's height
-(void)calculateLinesForEachNoticeWithWidth:(float)width andFont:(int)fontSize{
//    NSLog(@"诶嘿，我要开始算啦！");
    for(int i = 0; i < self.noticeList.count; i++){
        NoticeList *notice = [self.noticeList objectAtIndex:i];
        float height = [self heightCalculationWithWidthFixed:width forNotice:notice andFont:fontSize];
        NSNumber *num = [NSNumber numberWithFloat:(float)height];
        [self.heightsList addObject:num];
    }
}

-(float)heightCalculationWithWidthFixed:(float)width forNotice:(NoticeList *)notice andFont:(int)fontSize{
    if(notice.tipList.count < 1){   // corner case
        return 0.0;;
    }
    
    self.calculationHelper.font = [UIFont systemFontOfSize:fontSize];
    float height = 0;
    for (int i = 0; i < notice.tipList.count; i++) {
        TipList *list = [notice.tipList objectAtIndex:i];
        self.calculationHelper.text = list.desc;
        CGSize size = [self.calculationHelper sizeThatFits:CGSizeMake(width, MAXFLOAT)];
        height += size.height;
    }
    
    height += (notice.tipList.count + 1) * 10;  //  add seperation distance
    
    return height;
}

// MARK: Lazy load for properties
-(UILabel *)calculationHelper{
    if(!_calculationHelper){
        _calculationHelper = [[UILabel alloc] init];
        _calculationHelper.numberOfLines = 0;
    }
    return _calculationHelper;
}
-(NSMutableArray *)heightsList{
    if(!_heightsList){
        _heightsList = [NSMutableArray new];
    }
    return _heightsList;
}
@end
