function [ mLow, mHigh, mSum ] = FIND_MAX_SUBARRAY_RECURSIVE( A, low, high )
%FIND_MAX_SUBARRAY 寻找最大子数组
%   说明：使用分治法，计算时间复杂度为O(n*lg(n))
%   输入：A—数组（行向量），low—起始位置，high—结束位置
%   输出：最大子数组的起始位置mLow，结束位置mHigh，最大和mSum

if high == low
    mLow = low;
    mHigh = high;
    mSum = A(low);
    return;
else
    mid = floor((low+high)*0.5);
    [left_low, left_high, left_sum] = FIND_MAX_SUBARRAY_RECURSIVE(A,low,mid);
    [right_low,right_high,right_sum]= FIND_MAX_SUBARRAY_RECURSIVE(A,mid+1,high);
    [mid_low, mid_high, mid_sum] = FIND_MAX_CROSS_SUBARRY(A,low,mid,high);
    if left_sum >= right_sum && left_sum >= mid_sum
        mLow = left_low;
        mHigh = left_high;
        mSum = left_sum;
        return;
    elseif right_sum >= left_sum && right_sum >= mid_sum
        mLow = right_low;
        mHigh = right_high;
        mSum = right_sum;
        return;
    else
        mLow = mid_low;
        mHigh = mid_high;
        mSum = mid_sum;
        return;
    end
end


end

function [max_left,max_right,max_sum] = FIND_MAX_CROSS_SUBARRY(A,low,mid,high)
left_sum = -inf;
sum = 0;
for i = mid:-1:low
    sum = sum + A(i);
    if sum > left_sum
        left_sum = sum;
        max_left = i;
    end
end
right_sum = -inf;
sum = 0;
for j = mid+1:high
    sum = sum + A(j);
    if sum > right_sum
        right_sum = sum;
        max_right = j;
    end
end
max_sum = left_sum + right_sum;
end

