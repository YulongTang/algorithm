# subject: A Dynamic Programming solution for TSP
# author: 小智
# time: 2017-12-28 10:43:48

import math
import pandas as pd
import numpy as np
import copy
from operator import itemgetter

# small example
c = [[math.inf, 3, 6, 7],[5, math.inf, 2, 3],[6, 4, math.inf, 2],[3, 7, 5, math.inf]]
c = np.array(c)
n = len(c)
# big example
# c = np.loadtxt("big_example.txt", delimiter=',')
# n = len(c)

# dynamic programming
num_coding = []
for i in range(0, pow(2, n - 1)):
    coding = []
    res = i
    for j in range(n-1, -1, -1):
        coding.insert(0, math.floor(res/pow(2, j)))
        res -= math.floor(res/pow(2, j)) * pow(2, j)
    num_coding.append([i, coding, sum(coding)])
num_coding = sorted(num_coding, key=itemgetter(2, 0))
num_coding = pd.DataFrame(num_coding, columns=['num', 'coding', 'sum'])
# initialize
d = pd.DataFrame(np.zeros(shape=(n, pow(2, n - 1)))*np.nan, columns=range(0, pow(2, n - 1)))
for i in range(1, n):
    d[0][i] = c[i][0]
for j in range(1, pow(2, n - 1) - 1):
    print(j)
    V = np.where(num_coding['coding'][j])[0]
    V += 1
    for i in set(range(1, n)) - set(V):
        disdance_list = []
        for v in V:
            coding_list = copy.deepcopy(num_coding['coding'][j])
            coding_list[v-1] = 0
            res = 0
            for l in np.where(coding_list)[0]:
                res += pow(2, l)
            idx = num_coding[num_coding['num'] == res].index[0]
            disdance_list.append(c[i][v]+ d[idx][v])
        d[j][i] = min(disdance_list)
d_list = []
for k in range(1, n):
    coding_list = copy.deepcopy(num_coding['coding'][pow(2, n-1) - 1])
    coding_list[k - 1] = 0
    res = 0
    for l in np.where(coding_list)[0]:
        res += pow(2, l)
    idx = num_coding[num_coding['num'] == res].index[0]
    d_list.append(c[0][k] + d[idx][k])
result = min(d_list)
d[pow(2, n-1) - 1][0] = result
# calculate the best route
route = [0]
target = pow(2, n-1) - 1
while target > 0:
    V = np.where(num_coding['coding'][target])[0]
    V += 1
    d_list = []
    for k in V:
        coding_list = copy.deepcopy(num_coding['coding'][target])
        coding_list[k - 1] = 0
        res = 0
        for l in np.where(coding_list)[0]:
            res += pow(2, l)
        idx = num_coding[num_coding['num'] == res].index[0]
        d_list.append([c[0][k] + d[idx][k], k, idx])
    rst = min(d_list,  key=itemgetter(0))
    target = rst[2]
    route.append(rst[1])
route.append(0)

print('The best route is:', route)
print('The Minimal Distance is:', result)
