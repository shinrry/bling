//
//  secondViewController.h
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface secondViewController : UIViewController {
	NSInteger rightNum,firstNumb,secondNum,resultNum,symbol,counters,numRangeMax;
	UIButton *answer1,*answer2,*answer3,*answer4;
	UILabel *question;
	NSMutableArray *souceArray;//可以删除
	NSTimer *gameTime;
	BOOL buttonPressed,runNotRepeat;//默认的是NO

	int selectQuestionSender;
	UIView *finshView;
	
	BOOL isHalfAnimation;
	CATransition *lastAnimation;


}

@property (nonatomic,retain) CATransition *lastAnimation;


@property(retain,nonatomic)IBOutlet UIButton *answer1,*answer2,*answer3,*answer4;

@property(retain,nonatomic)IBOutlet UILabel *question;
@property(retain,nonatomic)IBOutlet UIView *finshView;

@property(retain,nonatomic)NSTimer *gameTime;

@property(nonatomic)NSInteger rightNum,firstNumb,secondNum,resultNum,symbol,counters,numRangeMax;//symbol表示0，1。0为加，1为减
@property(nonatomic)BOOL buttonPressed,runNotRepeat;


-(IBAction)answer1Pressed:(UIButton*)answerButton1;

-(void)changeAccordingSelectQuestionSender:(int)questionSort;
-(void)changeNumAndCheckAnswer;
-(void)buttonFly;
-(void)runGame;
-(void)runGameState2;
-(void)finshButton1Pressed;
-(void)finshButton2Pressed;
-(void)flicker;

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)buttonId;
@end
