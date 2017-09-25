function [ mLow, mHigh, mSum ] = FIND_MAX_SUBARRAY_DYNAMIC( A,low,high )
%FIND_MAX_SUBARRAY_DYNAMIC �õ����������
%   ˵������̬�滮������ʱ�临�Ӷ�ΪO(n)
%   ���룺���飨��������A����ʼλ��low����ֹλ��high
%   �����A��������������ʼλ��mLow����ֹλ��mHigh���Լ���mSum
left = low;
right = low;
sum = 0;          
max_sum = 0;                             % max_sum = A[left]+..+A[right]
for i = low:high
    last_sum = sum;                      % last_sum = A[left]+..+A[i-1]
    sum = sum + A(i);                    % sum = A[left]+..+A[i]
    if last_sum < 0 && A(i) > max_sum
        left = i;
        right = i;
        max_sum = A(i);
        sum = A(i);
        continue;
    end
    if sum > max_sum
        max_sum = sum;
        right = i;
    end 
end
mLow = left;
mHigh = right;
mSum = max_sum;
end

function [nLow,nHigh,nSum] = FIND_NEXT_SUBARRAY(A,low,high,sum,j)
% ��֪����A[1..j]����������飬ΪA[low..high]�����Ϊ[sum]
% ��������A[1..j+1]����������� A[nLow..nHigh]�����ΪnSum
% �㷨˵����A[nLow..nHigh]ҪôΪA[1..j]��������A[low..high]��ҪôΪĳ��������
%          A[i..j+1](low <= i <= j+1).
new_sum = 0;
max_sum = -inf;
new_low = low;
new_high = j+1;
for i=j+1:-1:low
    new_sum = new_sum + A(i);
    if new_sum > max_sum
        max_sum = new_sum;
        new_low = i;
    end
end
if max_sum > sum
    nLow = new_low;
    nHigh = new_high;
    nSum = max_sum;
else
    nLow = low;
    nHigh = high;
    nSum = sum;
end
end
