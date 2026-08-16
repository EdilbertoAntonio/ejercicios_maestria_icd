from collections import Counter
import matplotlib.pyplot as plt

# the following abstract is from the paper called "Reparameterized Complex-valued Neurons Can Efficiently Learn More than Real-valued Neurons via Gradient Descent"
text1 = """
    We study the high-dimensional training dynamics of a shallow neural network with
    quadratic activation in a teacher–student setup. We focus on the extensive-width regime,
    where the teacher and student network widths scale proportionally with the input dimension, and the sample size grows quadratically. 
    This scaling aims to describe overparameterized neural networks in which feature learning still plays a central role. In the
    high-dimensional limit, we derive a dynamical characterization of the gradient flow, in the
    spirit of dynamical mean-field theory (DMFT). Under ℓ2-regularization, we analyze these
    equations at long times and characterize the performance and spectral properties of the
    resulting estimator. This result provides a quantitative understanding of the effect of overparameterization on learning and generalization, 
    and reveals a double descent phenomenon
    in the presence of label noise, where generalization improves beyond interpolation. In
    the small regularization limit, we obtain an exact expression for the perfect recovery
    threshold as a function of the network widths, providing a precise characterization of how
    overparameterization influences recovery.
"""

# the following abstract is from the paper called "High-Dimensional Analysis of Gradient Flow for Extensive-Width Quadratic Neural Network"
text2 = """
    Complex-valued neural networks potentially possess better representations and performance than real-valued counterparts when dealing with some complicated tasks such as
    acoustic analysis, radar image classification, etc. Despite empirical successes, it remains unknown theoretically when and to what extent complex-valued neural networks outperform
    real-valued ones. We take one step in this direction by comparing the learnability of realvalued neurons and complex-valued neurons via gradient descent. We theoretically show
    that a complex-valued neuron can learn functions expressed by any one real-valued neuron
    and any one complex-valued neuron with convergence rates O(−3) and O(t−1) where t is
    the iteration index of gradient descent, respectively, whereas a two-layer real-valued neural
    network with finite width cannot learn a single non-degenerate complex-valued neuron. We
    prove that a complex-valued neuron learns a real-valued neuron with rate Ω(t−3), exponentially slower than the linear convergence rate of learning one real-valued neuron using
    a real-valued neuron. We then reparameterize the phase parameter of the complex-valued
    neuron and prove that a reparameterized complex-valued neuron can efficiently learn a realvalued neuron with a linear convergence rate. We further verify and extend these results
    via simulation experiments in more general settings.
"""

def word_dist(text):
    words = text.lower().replace(".","").split()
    counts = Counter(words)
    total = sum(counts.values())
    distribution = {key:(value/total) for key, value in counts.items()}
    
    return distribution

dist1 = word_dist(text1)
dist2 = word_dist(text2)

all_words = set(dist1.keys()).union(set(dist2.keys()))

variational_distance = sum([abs(dist1.get(word,0)-dist2.get(word,0)) for word in all_words])*(1/2)
print(variational_distance)

plt.bar(dist1.keys(), dist1.values(), color='red')
plt.bar(dist2.keys(), dist2.values(), color='blue')
plt.xticks(rotation=90)
plt.show()
