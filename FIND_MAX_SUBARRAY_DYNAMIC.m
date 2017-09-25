function [ mLow, mHigh, mSum ] = FIND_MAX_SUBARRAY_DYNAMIC( A,low,high )
%FIND_MAX_SUBARRAY_DYNAMIC 得到最大子数组
%   说明：动态规划方法，时间复杂度为O(n)
%   输入：数组（行向量）A，起始位置low，终止位置high
%   输出：A的最大子数组的起始位置mLow，终止位置mHigh，以及和mSum
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
% 以知数组A[1..j]的最大子数组，为A[low..high]，其和为[sum]
% 返回数组A[1..j+1]的最大子数组 A[nLow..nHigh]，其和为nSum
% 算法说明：A[nLow..nHigh]要么为A[1..j]的子数组A[low..high]，要么为某个子数组
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
