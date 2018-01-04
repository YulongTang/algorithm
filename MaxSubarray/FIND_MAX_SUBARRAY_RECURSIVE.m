function [ mLow, mHigh, mSum ] = FIND_MAX_SUBARRAY_RECURSIVE( A, low, high )
%FIND_MAX_SUBARRAY Ѱ�����������
%   ˵����ʹ�÷��η�������ʱ�临�Ӷ�ΪO(n*lg(n))
%   ���룺A�����飨����������low����ʼλ�ã�high������λ��
%   �����������������ʼλ��mLow������λ��mHigh������mSum

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

