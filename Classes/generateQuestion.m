#include <stdlib.h>
#include "generateQuestion.h"

#define max(a,b) a>b?a:b
#define min(a,b) a<b?a:b

#define ADD 1
#define MINUS 0
#define SMALL_RANGE 5

void swap(int *pa, int *pb)
{
    int c = *pa;
    *pa = *pb;
    *pb = c;
}

int getRandomFromZero(int range) // containing range
{
    return random() % (range + 1);
}

int getRandomFromOne(int range) // containing range
{
    return random() % range + 1;
}

int getRandom(int begin, int end) // containing begin and end
{
	return random() % (end - begin - 1) + begin;
}

int getBinaryRandom()
{
    return random() % 2;
}

void generateQuestion(int kind, int *pNum1, int *pNum2, char *pSymbol, int options[], int *pAnswer)
{
    int num1, num2, range, answer, wrongAnswer[3];
    char symbol;
	
    if (kind < 6) {
        if (ADD == getBinaryRandom()) {
            symbol = '+';
        }
        else {
            symbol = '-';
        }
    }
    else if (6 == kind) {
        symbol = 'x';
    }
    else {
        symbol = '/';
    }
	
    range = getGeneratorRange(kind);
	getTwoRandomFromOne(&num1, &num2, range);
	
    switch (kind) {
        case 2:
			num1 += 10; // no break here
        case 1:
        case 3:
        case 4:
        case 5:
            if ('+' == symbol) {
                answer = num1 + num2;
            }
            else {
                answer = num1 - num2;
            }
            break;
        case 6:
        case 7:
        case 8:
            num1++;
            num2++;
            answer = num1 * num2;
            break;
    }
	
	if (kind < 7) {
		getWrongAnswers(kind, answer, wrongAnswer);
        getOptions(answer, wrongAnswer, options);
        
        *pNum1 = num1;
        *pNum2 = num2;
        *pAnswer = answer;
        
	}
	else {
		getWrongNum(num1, wrongAnswer);
        getOptions(num1, wrongAnswer, options);
        
        *pNum1 = answer;
        *pNum2 = num2;
        *pAnswer = num1;
	}

    *pSymbol = symbol;
}

void getOptions(int answer, const int wrongAnswer[], int options[])
{
	int rightPosition, wrongPosition1, wrongPosition2;
	
	rightPosition = getRandomFromZero(3);
	options[rightPosition] = answer;
	
	do {
		wrongPosition1 = getRandomFromZero(3);
	} while (wrongPosition1 == rightPosition);
	options[wrongPosition1] = wrongAnswer[0];
	
	do {
		wrongPosition2 = getRandomFromZero(3);
	} while (wrongPosition2 == wrongPosition1 || wrongPosition2 == rightPosition);
	options[wrongPosition2] = wrongAnswer[1];
	
	options[6 - rightPosition - wrongPosition1 - wrongPosition2] = wrongAnswer[2];
}

void getTwoRandomFromOne(int *pa, int *pb, int range)
{
    int a, b;
	
    a = getRandomFromOne(range - 1);
    b = getRandomFromOne(range - a);
    if (a < b) {
        swap(&a, &b);
    } //assert a >= b
	
    *pa = a;
    *pb = b;
}

void getThreeUniqueOtherThanNum(int begin, int end, int result[], int num)
{
	do {
		result[0] = getRandom(begin, end);
	} while (result[0] == num);
	
	do {
		result[1] = getRandom(begin, end);
	} while (result[1] == num || result[1] == result[0]);
	
	do {
		result[2] = getRandom(begin, end);
	} while (result[2] == num || result[2] == result[0] || result[2] == result[1]);
}

void getTwoUniqueRandomFromOne(int *pa, int *pb, int range)
{
    int a, b;
	
    a = getRandomFromOne(range);
    do {
        b = getRandomFromOne(range);
    } while (a == b);
    *pa = a;
    *pb = b;
}

void getWrongAnswers(int kind, int answer, int wrongAnswer[])
{
    int opt1_left, diff1, diff2, range;
	
	range = getAnswerRange(kind);
	
    if (range > 9) {        		
        if (answer + 10 >= range) {
            opt1_left = 1;
        }
        else if (answer - 10 <= 0) {
            opt1_left = 0;
        }
        else {
			opt1_left = getBinaryRandom(); 
        }
		
        getTwoUniqueRandomFromOne(&diff1, &diff2, 9);
        if (opt1_left) {
            wrongAnswer[0] = answer - 10;
            wrongAnswer[1] = answer - diff1;
            wrongAnswer[2] = answer - diff2;
        }
        else {
            wrongAnswer[0] = answer + 10;
            wrongAnswer[1] = answer + diff1;
            wrongAnswer[2] = answer + diff2;
        }
    }
	else {
		do {
			wrongAnswer[0] = getRandomFromOne(range);
		} while (wrongAnswer[0] == answer);
		do {
			wrongAnswer[1] = getRandomFromOne(range);
		} while (wrongAnswer[1] == answer || wrongAnswer[1] == wrongAnswer[0]);
		do {
			wrongAnswer[2] = getRandomFromOne(range);
		} while (wrongAnswer[2] == answer || wrongAnswer[2] == wrongAnswer[0] || wrongAnswer[2] == wrongAnswer[1]);
	}

}

void getWrongNum(int num1, int wrongAnswer[])
{
	int begin;
	
	begin = max(1, num1 - SMALL_RANGE);
	getThreeUniqueOtherThanNum(begin, num1 + SMALL_RANGE, wrongAnswer, num1);
}

int getAnswerRange(int kind)
{
    switch (kind) {
        case 1:
		case 7:
        case 8:
            return 9;
        case 2:
        case 3:
            return 19;
        case 4:
            return 49;
        case 5:
            return 99;
        case 6:
            return 81;
    }
}

int getGeneratorRange(int kind)
{
	switch (kind) {
        case 1:
        case 2:
            return 9;
        case 3:
            return 19;
        case 4:
            return 49;
        case 5:
            return 99;
        case 6:
        case 7:
        case 8:
            return 8;
    }
}	
