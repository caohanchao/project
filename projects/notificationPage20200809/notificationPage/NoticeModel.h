//
//  NoticeModel.h
//  notificationPage
//
//  Created by 丁东 on 2020/8/7.
//  Copyright © 2020 zxc. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TipList;
@interface TipList : JSONModel
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *desc;
@end


@protocol NoticeList;
@interface NoticeList : JSONModel

@property(nonatomic) int ID;
@property(nonatomic) int type;
@property(nonatomic) int relateID;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *contentTip;
@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSArray<TipList> *tipList;
@property(nonatomic, strong) NSString *hasDetail;
//@property(nonatomic) long postTime;
@property(nonatomic) NSString *postTime;

@end


@interface NoticeModel : JSONModel

@property(nonatomic, strong) NSMutableArray<NoticeList> *noticeList;
@property(nonatomic, strong) NSMutableArray<Ignore> *heightsList;

-(void)calculateLinesForEachNoticeWithWidth:(float)width andFont:(int)fontSize;

@end

NS_ASSUME_NONNULL_END
