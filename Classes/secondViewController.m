//
//  secondViewController.m
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import "secondViewController.h"
#import "nstimer.h"

@implementation secondViewController
@synthesize firstNumb,secondNum,resultNum,symbol,question,counters,rightNum;
@synthesize buttonPressed,runNotRepeat,gameTime,numRangeMax;//moveVelocity;
@synthesize answer1,answer2,answer3,answer4;
@synthesize lastAnimation;
@synthesize finshView;
#define speed 3.92//这样设置可以改变按钮走过的时间

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)button_id
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if(self == nil)
    {
        return nil;
    }
    selectQuestionSender = button_id;
	NSLog(@"这个值终于传过来了： %d",button_id);
    return self;
}



-(IBAction)answer1Pressed:(UIButton*)answerButton1{
		//resultNum=(symbol%4==1)?firstNumb+secondNum:firstNumb-secondNum;
	buttonPressed=YES;
	if(answerButton1.tag!=symbol)
	{
		counters++;
		NSLog(@"回答错误");
	}
	else
	{
		counters++;
		rightNum++;
		NSLog(@"回答正确");
	}
	if (counters>10) 
	{
		NSLog(@"实体结束");
	    [self runGameState2];
		
	}	
}


-(void)timeOver{
   if(counters<11){
	[self runGameState2];
   }
	else{  
		NSLog(@"Time over!");
		answer1.userInteractionEnabled=NO;
		answer2.userInteractionEnabled=NO;
		answer3.userInteractionEnabled=NO;
		answer4.userInteractionEnabled=NO;
   }
}


-(void)runGame{
	
	gameTime=[NSTimer scheduledTimerWithTimeInterval:0.05 
									 target:self 
								   selector:@selector(buttonMove) 
								   userInfo:nil 
									repeats:YES];
	
}

-(void)runGameState2{
	answer1.userInteractionEnabled=NO;
	answer2.userInteractionEnabled=NO;
	answer3.userInteractionEnabled=NO;
	answer4.userInteractionEnabled=NO;
	[gameTime invalidate];

	CGRect lastViewFrame=CGRectMake(20, 20, 280, 179);//某一个四边形
	finshView=[[UIView alloc] initWithFrame:lastViewFrame];
	finshView.backgroundColor=[UIColor blackColor];
	finshView.alpha=0.7;	
	UIButton* finshButton1= [[UIButton alloc] initWithFrame:CGRectMake(60,142, 72, 37)];
	UIButton* finshButton2= [[UIButton alloc] initWithFrame:CGRectMake(174,142, 72, 37)];
	[UIButton buttonWithType:UIButtonTypeRoundedRect];
	[finshButton1 setBackgroundImage:nil forState:UIControlStateNormal];
	[finshButton1 addTarget:self 
				   action:@selector(finshButton1Pressed)
		 forControlEvents:UIControlEventTouchDown]; 
	[finshButton2 setBackgroundImage:nil forState:UIControlStateNormal];
	[finshButton2 addTarget:self action:@selector(finshButton2Pressed)
		   forControlEvents:UIControlEventTouchDown];
	[finshButton1 setBackgroundColor:[UIColor blueColor]];
	[finshButton2 setBackgroundColor:[UIColor whiteColor]];
		//finshButton2.hidden=YES;
	[finshView addSubview:finshButton1];
	[finshView addSubview:finshButton2];
	[finshButton1 release];
	[finshButton2 release];
		//[self a:@selector(flicker) interval:1];
	[self flicker];
	[self.view addSubview:finshView];
	[self flicker];
	if (rightNum>10*0.8)
	{
		NSLog(@"正确");
		
	}
	else
		NSLog(@"11题结束后错误");
}
-(void)finshButton1Pressed{
	[finshView removeFromSuperview];
	[self viewDidLoad];
}
-(void)finshButton2Pressed{
	
	[self.view removeFromSuperview];
}
-(void)flicker{
	
	CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
	animation.type = @"rippleEffect";
	[self.view.layer addAnimation:animation forKey:@"animation"];
	self.lastAnimation = animation;
	
	[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];//Just remove, not release or dealloc
	isHalfAnimation = YES;
			
}
-(void)changeAccordingSelectQuestionSender:(int)questionSort{
	switch (questionSort) {
		case 1:
			numRangeMax=10;
			break;
		case 2:
			numRangeMax=20;
			break;
		case 3:
			numRangeMax=20;
			break;
		case 4:
			numRangeMax=50;
			break;
		case 5:
			numRangeMax=100;
			break;
		case 6:
			numRangeMax=9;
			break;
		case 7:
			numRangeMax=81;
			break;
		case 8:
			numRangeMax=81;
			break;
		default:
			break;
	}
	firstNumb=random()%numRangeMax;
	secondNum=random()%numRangeMax;
	while (firstNumb==secondNum) {
		firstNumb=random()%numRangeMax;
	}
	symbol=random()%4+1;      //符号与答案随机
	NSLog(@"%d",symbol);
	if (symbol%2==1)
	{
		if(selectQuestionSender==3)
		{
			while (firstNumb+secondNum<numRangeMax) {
				firstNumb=random()%numRangeMax;//这个只能解决加减乘除法
				secondNum=random()%numRangeMax;
			}
		}
		else {
			while (firstNumb+secondNum>numRangeMax) {
				firstNumb=random()%numRangeMax;
				secondNum=random()%numRangeMax;
			}
		}
//生成加法或乘法
		if(selectQuestionSender<6)
		{
			NSString *tempString=[[NSString alloc]initWithFormat:@"%d + %d",firstNumb,secondNum];
			question.text=tempString;
			[tempString release];
			resultNum=firstNumb+secondNum;
		}
		else
		{
			switch (selectQuestionSender) 
			{
				case 6:
				     {NSString *tempString2=[[NSString alloc]initWithFormat:@"%d * %d",firstNumb,secondNum];
				     question.text=tempString2;
				     [tempString2 release];
					 resultNum=firstNumb*secondNum;}
				break;
				
/*下面这个是除法比较复杂*/
				case 7:{
					NSString *tempString=[[NSString alloc]initWithFormat:@"%d + %d",firstNumb,secondNum];
					question.text=tempString;
					[tempString release];
					resultNum=firstNumb+secondNum;
				}
					break;
/*下面这个是带余除法比较复杂*/
				case 8:{
					NSString *tempString=[[NSString alloc]initWithFormat:@"%d + %d",firstNumb,secondNum];
					question.text=tempString;
					[tempString release];
					resultNum=firstNumb+secondNum;
				}
					break;

				default:
					break;
			}
		}
	}
	
	else
	{
		int a=firstNumb;
		if (a<secondNum) 
		{
			firstNumb=secondNum;
			secondNum=a;
		}
		if(selectQuestionSender<6)
		{
			NSString *tempString=[[NSString alloc]initWithFormat:@"%d － %d",firstNumb,secondNum];
			question.text=tempString;
			[tempString release];
			resultNum=firstNumb-secondNum;
		}
		else
		{
			switch (selectQuestionSender) 
			{
				case 6:{
					NSString *tempString=[[NSString alloc]initWithFormat:@"%d * %d",firstNumb,secondNum];
					question.text=tempString;
					[tempString release];
					resultNum=firstNumb*secondNum;
				}
					break;
					/*下面这个是除法比较复杂*/
				case 7:{
					NSString *tempString=[[NSString alloc]initWithFormat:@"%d + %d",firstNumb,secondNum];
					question.text=tempString;
					[tempString release];
					resultNum=firstNumb+secondNum;
				}
					break;
					/*下面这个是带余除法比较复杂*/
				case 8:{
					NSString *tempString=[[NSString alloc]initWithFormat:@"%d + %d",firstNumb,secondNum];
					question.text=tempString;
					[tempString release];
					resultNum=firstNumb+secondNum;
				}
					break;
					
				default:
					break;
			}
		}
	}
		
}
-(void)changeNumAndCheckAnswer{//实际加载图片后需要改正
	NSLog(@"红红火火红红火火 改变 红红火火红红火火");
	[self changeAccordingSelectQuestionSender:selectQuestionSender];
			//BOOL state=changeNum;
	
	if (symbol==1) 
	{
		NSString *temp1=[[NSString alloc]initWithFormat:@"%d",resultNum];
		NSString *temp2=[[NSString alloc]initWithFormat:@"%d",(resultNum+9)%numRangeMax];
		NSString *temp3=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-3];
		NSString *temp4=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-2];
		[answer4 setTitle:temp2 forState:NO];
		[answer1 setTitle:temp1 forState:NO];
		[answer2 setTitle:temp3 forState:NO];
		[answer3 setTitle:temp4 forState:NO];
		[temp1 release];
		[temp2 release];
		[temp3 release];
		[temp4 release];
	}
	if (symbol==2)
	{
		NSString *temp1=[[NSString alloc]initWithFormat:@"%d",resultNum];
		NSString *temp2=[[NSString alloc]initWithFormat:@"%d",(resultNum+9)%numRangeMax];
		NSString *temp3=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-1];
		NSString *temp4=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-2];
		[answer4 setTitle:temp3 forState:NO];
		[answer1 setTitle:temp2 forState:NO];
		[answer2 setTitle:temp1 forState:NO];
		[answer3 setTitle:temp4 forState:NO];
		[temp1 release];
		[temp2 release];
		[temp3 release];
		[temp4 release];
	}
	if (symbol==3)
	{
		NSString *temp1=[[NSString alloc]initWithFormat:@"%d",resultNum];
		NSString *temp2=[[NSString alloc]initWithFormat:@"%d",(resultNum+9)%numRangeMax];
		NSString *temp3=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-1];
		NSString *temp4=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-2];
		[answer4 setTitle:temp4 forState:NO];
		[answer1 setTitle:temp2 forState:NO];
		[answer2 setTitle:temp3 forState:NO];
		[answer3 setTitle:temp1 forState:NO];
		[temp1 release];
		[temp2 release];
		[temp3 release];
		[temp4 release];
	}
	if (symbol==4)
	{
		NSString *temp1=[[NSString alloc]initWithFormat:@"%d",resultNum];
		NSString *temp2=[[NSString alloc]initWithFormat:@"%d",(resultNum+9)%numRangeMax];
		NSString *temp3=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-2];
		NSString *temp4=[[NSString alloc]initWithFormat:@"%d",(resultNum+8)%numRangeMax-1];
		[answer4 setTitle:temp1 forState:NO];
		[answer1 setTitle:temp2 forState:NO];
		[answer2 setTitle:temp3 forState:NO];
		[answer3 setTitle:temp4 forState:NO];
		[temp1 release];
		[temp2 release];
		[temp3 release];
		[temp4 release];
	}/*以上方法为较传统*/
}

-(void)buttonFly{
		//answer1.frame=CGRectMake(answer1.frame.origin.x, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);
	[UIView beginAnimations:nil context:answer1];//开始动画
	[UIView beginAnimations:nil context:answer2];
	[UIView beginAnimations:nil context:answer3];
	[UIView beginAnimations:nil context:answer4];
	[UIView setAnimationDuration:0.5];
	answer1.frame = CGRectMake(393, answer1.frame.origin.y,answer1.frame.size.width, answer1.frame.size.height);//
	answer2.frame = CGRectMake(393, answer2.frame.origin.y,answer2.frame.size.width, answer2.frame.size.height);
	answer3.frame = CGRectMake(393, answer3.frame.origin.y,answer3.frame.size.width, answer3.frame.size.height);
	answer4.frame = CGRectMake(393, answer4.frame.origin.y,answer4.frame.size.width, answer4.frame.size.height);
	[UIView setAnimationDelegate:self]; 
	[UIView commitAnimations];
}

-(void)buttonMove{
	
	
	if(!buttonPressed)//如果没有点击按钮，按钮正常移动
	{
		
		
		if (answer2.frame.origin.x<392){
			answer2.frame = CGRectMake(answer2.frame.origin.x+speed,
									   answer2.frame.origin.y,
									   answer2.frame.size.width,
									   answer2.frame.size.height);
			answer1.frame = CGRectMake(answer1.frame.origin.x+speed,
									   answer1.frame.origin.y,
									   answer1.frame.size.width,
									   answer1.frame.size.height);
			answer3.frame = CGRectMake(answer3.frame.origin.x+speed,
									   answer3.frame.origin.y,
									   answer3.frame.size.width,
									   answer3.frame.size.height);
			answer4.frame = CGRectMake(answer4.frame.origin.x+speed,
									   answer4.frame.origin.y,
									   answer4.frame.size.width,
									   answer4.frame.size.height);
		}
		else
		{
			answer2.frame = CGRectMake(-72,
									   answer2.frame.origin.y,
									   answer2.frame.size.width,
									   answer2.frame.size.height);
		
			answer3.frame = CGRectMake(-72, 
									   answer3.frame.origin.y,
									   answer3.frame.size.width,
									   answer3.frame.size.height);
		
			answer4.frame = CGRectMake(-72, 
									   answer4.frame.origin.y,
									   answer4.frame.size.width,
									   answer4.frame.size.height);

			answer1.frame = CGRectMake(-72, 
									   answer1.frame.origin.y,
									   answer1.frame.size.width,
									   answer1.frame.size.height);
			[self changeNumAndCheckAnswer];//出界后就便换
			
		}
	}	
	else
	{
		[self buttonFly];
		[self changeNumAndCheckAnswer];
		buttonPressed=NO;
	}
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	counters=0;
	rightNum=0;
	[self changeNumAndCheckAnswer];
	[self runGame];
	answer1.userInteractionEnabled=YES;
	answer2.userInteractionEnabled=YES;
	answer3.userInteractionEnabled=YES;
	answer4.userInteractionEnabled=YES;
	[NSTimer scheduledTimerWithTimeInterval:60 //规定的时间
									 target:self 
								   selector:@selector(timeOver) 
								   userInfo:nil 
									repeats:NO];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[finshView release];
	[gameTime fire];
	//[stopTime release];
	[question release];
	[answer1 release];
	[answer2 release];
	[answer3 release];
	[answer4 release];
	[super dealloc];
}

@end

/*if (!buttonPressed) {
 NSLog(@"是YES");
 }
 
 /UIImage *miss=[UIImage imageNamed:@"miss.png"];	
 //UIImageView *view2 = [[UIImageView alloc] initWithImage:miss];
 //[self.view addSubview:answer1];
 [UIView beginAnimations:nil context:answer1];//开始动画
 [UIView setAnimationDuration:10];
 answer1.frame = CGRectMake(400, 135,72, 37);//
 [UIView setAnimationDelegate:self]; 
 [UIView commitAnimations]; 
 //以下方法为较传统

 answer1.frame=CGRectMake(-72, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);
 [UIView beginAnimations:nil context:answer1];//开始动画
 [UIView setAnimationDuration:3];
 answer1.frame = CGRectMake(393, answer1.frame.origin.y,answer1.frame.size.width, answer1.frame.size.height);//
 [UIView setAnimationDelegate:self]; 
 [UIView commitAnimations];
 answer1.userInteractionEnabled = NO; 
 if (answer1.frame.origin.x>392){
 answer1.frame=CGRectMake(-72, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);
 [UIView beginAnimations:nil context:answer1];//开始动画
 [UIView setAnimationDuration:3];
 answer1.frame = CGRectMake(393, answer1.frame.origin.y,answer1.frame.size.width, answer1.frame.size.height);//
 [UIView setAnimationDelegate:self]; 
 [UIView commitAnimations];
 }
 
 */		//int timers=0;
		/*实现图片闪烁
		 一个方法a
		 
		 if (bg1.opacity == 70.0f) {
		 bg1.opacity = 100.0f;
		 }
		 else {
		 bg1.opacity = 70.0f;
		 }
		 
		 然后 [self schedule:@selector(a) interval:1]; */
