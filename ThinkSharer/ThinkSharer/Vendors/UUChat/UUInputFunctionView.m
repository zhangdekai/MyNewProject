//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUInputFunctionView.h"
#import "Mp3Recorder.h"
#import "UUProgressHUD.h"

@interface UUInputFunctionView ()<UITextViewDelegate>//Mp3RecorderDelegate
{
    BOOL isbeginVoiceRecord;
    Mp3Recorder *MP3;
    NSInteger playTime;
    NSTimer *playTimer;
    
//    UILabel *placeHold;//输入框的提示语
}
@end

@implementation UUInputFunctionView

- (id)initWithSuperVC:(BasicViewController *)superVC
{
    
    self.superVC = superVC;
    CGRect frame = CGRectMake(0, Main_Screen_Height-75, Main_Screen_Width, 75);
    
    self = [super initWithFrame:frame];
    if (self) {
//        MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor backgroundGrayColorA];

        //发送消息
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSendMessage.frame = CGRectMake(Main_Screen_Width- 55 - 10, 0, 55, 35);
        self.isAbleToSendTextMessage = NO;
        [self.btnSendMessage setTitle:@"发送" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundColor:[UIColor backgroundGrayColorA]];
//        [self.btnSendMessage setBackgroundImage:[UIImage imageNamed:@"Chat_take_picture"] forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        self.btnSendMessage.layer.masksToBounds = YES;
        self.btnSendMessage.layer.cornerRadius = 5;
        
        //改变状态（语音、文字）
//        self.btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.btnChangeVoiceState.frame = CGRectMake(5, 5, 30, 30);
//        isbeginVoiceRecord = NO;
//        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
//        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self.btnChangeVoiceState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.btnChangeVoiceState];

        //语音录入键
//        self.btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.btnVoiceRecord.frame = CGRectMake(70, 5, Main_Screen_Width-70*2, 30);
//        self.btnVoiceRecord.hidden = YES;
//        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
//        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
//        [self.btnVoiceRecord setTitle:@"Hold to Talk" forState:UIControlStateNormal];
//        [self.btnVoiceRecord setTitle:@"Release to Send" forState:UIControlStateHighlighted];
//        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
//        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
////        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
//        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
//        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
//        [self addSubview:self.btnVoiceRecord];
        
        //输入框
        self.TextViewInput = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, Main_Screen_Width-2*45, 35)];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.TextViewInput];
        
        //输入框的提示语
//        placeHold = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
//        placeHold.text = @"";//Input the contents here
//        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
//        [self.TextViewInput addSubview:placeHold];
        
//        //分割线
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
        
        
        //下边Icon
        NSArray *iconName = @[@"chat_photos",@"chat_camera",@"chat_expression",@"chat_location",@"chart_comment"];
        CGFloat iconWH = [TSPublicTool getRealPX:21];
        CGFloat leftGap = [TSPublicTool getRealPX:25];
        CGFloat middleGap = (ScreenWidth - (2 * leftGap + 5 * iconWH)) / 4;
        
        for (int i = 0; i < 5; i++) {
            UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:
                                 CGRectMake(leftGap + i * (iconWH + middleGap), 45, iconWH, iconWH)];
            [self addSubview:iconImageView];
            iconImageView.image = [UIImage imageNamed:iconName[i]];
            iconImageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tapMethod:)];
            [iconImageView addGestureRecognizer:tap];
            
            iconImageView.tag = 100 + i;
        }
        
        
    }
    return self;
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag - 100;
    
    [self.delegate UUInputFunctionView:self touchIndex:tag];
    
}

#pragma mark - 录音touch事件
- (void)beginConvert {
    
}
- (void)beginRecordVoice:(UIButton *)button
{
    [MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}

- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"Cancel"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Release to cancel"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"Slide up to cancel"];
}


- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}

#pragma mark - Mp3RecorderDelegate
/*
//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.delegate UUInputFunctionView:self sendVoice:voiceData time:playTime+1];
    [UUProgressHUD dismissWithSuccess:@"Success"];
   
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"Too short"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

//改变输入与录音状态
- (void)voiceRecord:(UIButton *)sender
{
    self.btnVoiceRecord.hidden = !self.btnVoiceRecord.hidden;
    self.TextViewInput.hidden  = !self.TextViewInput.hidden;
    isbeginVoiceRecord = !isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.TextViewInput resignFirstResponder];
    }else{
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.TextViewInput becomeFirstResponder];
    }
}
 */

//发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
//    if (self.isAbleToSendTextMessage) {
        NSString *resultStr = [self.TextViewInput.text stringByReplacingOccurrencesOfString:@"   " withString:@""];
        [self.delegate UUInputFunctionView:self sendMessage:resultStr];
//    }
//    else{
//        [self.TextViewInput resignFirstResponder];
//        UIActionSheet *actionSheet= [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Images",nil];
//        [actionSheet showInView:self.window];
        
//        [self.superVC selectPhoto:9];

//    }
}

#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //placeHold.hidden = self.TextViewInput.text.length > 0;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self changeSendBtnWithPhoto:textView.text.length>0?NO:YES];
    //placeHold.hidden = textView.text.length>0;
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    if (isPhoto) {
        self.btnSendMessage.enabled = NO;
        [self.btnSendMessage setBackgroundColor:[UIColor backgroundGrayColorA]];
    } else {
        self.btnSendMessage.enabled = YES;
        [self.btnSendMessage setBackgroundColor:[UIColor mainColorBlue]];

    }
    
//    self.isAbleToSendTextMessage = !isPhoto;
//    [self.btnSendMessage setTitle:isPhoto?@"":@"发送" forState:UIControlStateNormal];
//    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
//    UIImage *image = [UIImage imageNamed:isPhoto?@"Chat_take_picture":@"chat_send_message"];
//    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //placeHold.hidden = self.TextViewInput.text.length > 0;
}


#pragma mark - Add Picture
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [self addCarema];
//    }else if (buttonIndex == 1){
//        [self openPicLibrary];
//    }
//}
//
//-(void)addCarema{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self.superVC presentViewController:picker animated:YES completion:^{}];
//    }else{
//        //如果没有提示用户
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"Your device don't have camera" delegate:nil cancelButtonTitle:@"Sure" otherButtonTitles:nil];
////        [alert show];
//        
//        UIAlertController *alterContr = [UIAlertController alertControllerWithTitle:@"Tip" message:@"Your device don't have camera" preferredStyle:(UIAlertControllerStyleAlert)];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Sure" style:(UIAlertActionStyleCancel) handler:nil];
//        [alterContr addAction:action];
//        [self.viewController presentViewController:alterContr animated:YES completion:nil];
//    }
//}
//
//-(void)openPicLibrary{
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self.superVC presentViewController:picker animated:YES completion:^{
//        }];
//    }
//}
//
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    [self.superVC dismissViewControllerAnimated:YES completion:^{
//        [self.delegate UUInputFunctionView:self sendPicture:editImage];
//    }];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self.superVC dismissViewControllerAnimated:YES completion:nil];
//}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
