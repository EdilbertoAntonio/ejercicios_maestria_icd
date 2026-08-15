import numpy as np
# from scipy.spatial import distance
# distance.euclidean(a,b)

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
            dist = euc_dist(point_A,point_B)
            row.append(dist)
        matrix.append(row)

    return matrix

def min_distance(A,B):
    distance = []

    for point_A in A:
        aux = [];
        for point_B in B:
            dist = euc_dist(point_A,point_B)
            aux.append(dist)
        distance.append(min(aux))

    return distance

def max_distance(A,B):
    distance = []

    for point_A in A:
        aux = [];
        for point_B in B:
            dist = euc_dist(point_A,point_B)
            aux.append(dist)
        distance.append(max(aux))

    return distance

def average_distance(A,B):
    distance = []

    for point_A in A:
        for point_B in B:
            dist = euc_dist(point_A,point_B)
            distance.append(dist)

    return sum(distance)/len(distance)
        

prueba = average_distance(A,B)
print(prueba)



# def min_all_pairs(A,B):

# def centroid_dist():
