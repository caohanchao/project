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

-(void)setPostTimeWithNSDictionary:(NSDictionary *)dictionary{
    NSLog(@"调用了");
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:(long)dictionary[@"postTime"]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
//    self.postTime = [NSString stringWithFormat:@"%@", localDate];
    self.postTime = @"今天";
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    if(self = [super initWithDictionary:dict error:err]){
//        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[dict[@"postTime"] integerValue]];
//        NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        NSInteger interval = [zone secondsFromGMTForDate:date];
//        NSDate *localDate = [date dateByAddingTimeInterval:interval];
//        self.postTime = [NSString stringWithFormat:@"%@", localDate];
        
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




-(void)calculateLinesForEachNoticeWithWidth:(float)width andFont:(int)fontSize{
    NSLog(@"诶嘿，我要开始算啦！");
    
    for(int i = 0; i < self.noticeList.count; i++){
        NoticeList *notice = [self.noticeList objectAtIndex:i];
        float height = [self heightCalculationWithWidthFixed:width forNotice:notice andFont:fontSize];
        NSLog(@"curLine:%f", height);
        NSNumber *num = [NSNumber numberWithFloat:(float)height];
        NSLog(@"num: %@", num);
        [self.heightsList addObject:num];
        NSLog(@"arrCount: %d", (int)self.heightsList.count);
    }
}

-(float)heightCalculationWithWidthFixed:(float)width forNotice:(NoticeList *)notice andFont:(int)fontSize{
//    NoticeList *notice = [self.noticeList objectAtIndex:index];
    if(notice.tipList.count < 1){
        return 0.0;;
    }
    
    self.calculationHelper.font = [UIFont systemFontOfSize:fontSize];
    float height = 0;
    int lines = 0;
    for (int i = 0; i < notice.tipList.count; i++) {
        TipList *list = [notice.tipList objectAtIndex:i];
        self.calculationHelper.text = list.desc;
        CGSize size = [self.calculationHelper sizeThatFits:CGSizeMake(width, MAXFLOAT)];
        height += size.height;
        lines += size.height / self.calculationHelper.font.lineHeight;
    }
    
    height += (notice.tipList.count + 1) * 10;
    
    
    return height;
}

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
