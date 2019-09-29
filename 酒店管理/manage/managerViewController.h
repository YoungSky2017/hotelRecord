//
//  managerViewController.h
//  酒店管理
//
//  Created by 杨奇 on 2019/9/19.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface managerViewController : UIViewController
@property (nonatomic, strong, readwrite)UILabel *nameLabel;
@property (nonatomic, strong, readwrite)UILabel *IDLabel;
@property (nonatomic, strong, readwrite)UITextField *nameText;
@property (nonatomic, strong, readwrite)UITextField *IDText;

@property (nonatomic, strong, readwrite)UILabel *hotelLabel;
@property (nonatomic, strong, readwrite)UILabel *roomLabel;
@property (nonatomic, strong, readwrite)UILabel *timeLabel;
@property (nonatomic, strong, readwrite)UILabel *countLabel;
@property (nonatomic, strong, readwrite)UILabel *dayLabel;
@property (nonatomic, strong, readwrite)UILabel *priceLabel;

@property (nonatomic, copy, readwrite)UITextField *hotelTextField;
@property (nonatomic, strong, readwrite)UITextField *roomTextField;
@property (nonatomic, strong, readwrite)UITextField *timeTextField;
@property (nonatomic, strong, readwrite)UITextField *countTextField;
@property (nonatomic, strong, readwrite)UITextField *dayTextField;
@property (nonatomic, strong, readwrite)UITextField *priceTextField;

@property (nonatomic, strong, readwrite)UILabel *leftLabel;

@property(nonatomic, strong, readwrite)UIDatePicker *datePicker;

@property(nonatomic, strong, readwrite)NSArray *peopleArray;
@property(nonatomic, strong, readwrite)NSArray *daysArray;
@property(nonatomic, strong, readwrite)UIPickerView *countPickerView;
@property(nonatomic, strong, readwrite)UIPickerView *daysPickerView;


@end

NS_ASSUME_NONNULL_END
