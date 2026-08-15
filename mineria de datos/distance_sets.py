import numpy as np
import pandas as pd
# from scipy.spatial import distance

# sets
A = np.array([[1,1],[2,2],[1,2]])
B = np.array([[0,1],[2,5],[1,3]])

def euc_dist(point1, point2):
    dist1 = abs(point1[0]-point2[0])
    dist2 = abs(point1[1]-point2[1])
    res = np.sqrt(dist1**2+dist2**2)
    return res

def distance_matrix(A,B):
    matrix = []
    for point_A in A:
        row = [];
        for point_B in B:
            dist = euc_dist(point_A,point_B) # distance.euclidean(A,B)
            row.append(dist)
        matrix.append(row)
    return matrix

def list_min_dist(A,B):
    matrix = distance_matrix(A,B)
    distance = [float(min(row)) for row in matrix]
    return distance

def list_max_dist(A,B):
    matrix = distance_matrix(A,B)
    distance = [float(max(row)) for row in matrix]
    return distance

def average_distance(A,B):
    matrix = distance_matrix(A,B)
    avg = float(np.mean(matrix))
    return avg

def dist_between_avgs(A, B):
    avg_A = np.mean(A, axis=0)
    avg_B = np.mean(B, axis=0)
    dist = float(euc_dist(avg_A, avg_B))

    return dist

def hausdorff_distance(A, B):
    max_AB = max(list_min_dist(A,B))
    max_BA = max(list_min_dist(B,A))
    dist = max(max_AB, max_BA)
    return dist

resultados = [min(list_min_dist(A,B)),
            max(list_min_dist(A,B)),
            average_distance(A,B),
            dist_between_avgs(A,B),
            hausdorff_distance(A,B)]

resp = pd.DataFrame({'Distance':resultados})
resp.index = ['Mininum distance over all pairs', 'Maximum distance over all pairs', 'Average distance over all pairs',
            'Distance between averages', 'Hausdorff distance']

print(resp)


# prueba1 = list_min_dist(A,B)
# print(prueba1)
# prueba2 = list_min_dist(B,A)
# print(prueba2)
# prueba = hausdorff_distance(A,B)
# print(prueba)

# def min_all_pairs(A,B):

# def centroid_dist():
