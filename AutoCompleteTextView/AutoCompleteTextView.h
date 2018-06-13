//
//  AutoCompleteTextView.h
//  AutoCompleteTextViewDemo
//
//  Created by 白仕云 on 2018/6/13.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoCompleteShowList.h"

//  #################   文本输入框  ##########################

@interface AutoCompleteTextView : UITextField

/**
 重置list的高度
 */
@property (nonatomic ,assign)CGFloat ShowListHight;

/**
 重新init方法
 @param frame 位置大小
  @param superView list的父视图（也就是list add 的View）
 */
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;

/**
 筛选数据
 */
@property (nonatomic ,strong)NSMutableArray *dataArray;

/**
 监听输入文本框内容变化
 */
@property (nonatomic ,copy)void(^AutoCompleteTextViewTextFieldTextChange)(NSString *searchTextString);


/**
 列表上内容赋值
 */
@property (nonatomic ,copy)void(^BSYAutoCompleteShowChange)(NSIndexPath *indexPath,AutoCompleteShowListCell *cell,id cellObj);
;

/**
 点击列表内容获取点击的数据
 */
@property (nonatomic ,copy)void(^didSelectRowAtIndexPathChange)(NSIndexPath *indexPath,AutoCompleteShowListCell *cell,id cellObj);
@end
