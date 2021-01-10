#!/usr/bin/env python
# coding: utf-8

# In[ ]:


def print_dic(**arg):
    for key, value in arg.items():
        print(key,":",value)


# In[ ]:


def max_min(*num) :
    # Docstring : 함수에 설명을 해놓은 것
    # 여러줄 입력가능
    """
        max_min(): 여러개의 파라미터에서 최대와 최솟값을 구하는 함수 \n
            - num : 여러개 입력파라마터를 설정
    """
    min_val = num[0]
    max_val = num[0]
    
    for x in num :
        if x > max_val :
            max_val = x
        if x < min_val :
            min_val = x
        
    return max_val, min_val


# In[ ]:


# 리턴값이 여러개인 함수
def sum_sub(num1, num2) :
    """
        sum_sub(): 두 수의 합과 차 구하는 함수 \n
            - num1 : 숫자 1 \n
            - num2 : 숫자 2 \n
    """
    hap = num1 + num2
    sub = num1 - num2
    
    return hap, sub


# In[ ]:


def add2(*num) :
    hap = 0
    for x in num :
        hap += x
        
    return hap


# In[ ]:





# In[ ]:





# In[ ]:




