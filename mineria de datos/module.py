import pandas as pd
import numpy as np
from scipy import stats

def summary_univariate(x:pd.Series) -> pd.Series:
    return pd.Series({'count':x.count(), 
                        'missing':x.isnull().sum(), 
                        'pct_missing':x.isnull().mean()*100, 
                        'mean':x.mean(),
                        'median':np.median(x),
                        'mode':stats.mode(x, keepdims=True).mode[0], #x.mode()
                        'variance':x.var(),#np.var(x), #x.var(x)
                        'std':x.std(),#np.std(x), 
                        'min':x.min(),#np.min(x),
                        'max':x.max(),#np.max(x),
                        'Q1':x.quantile(0.25),#np.quantile(x,0.25),
                        'Q3':x.quantile(0.75),#np.quantile(x,0.75),
                        'IQR':x.quantile(0.75)-x.quantile(0.25),#np.quantile(x,0.75)-np.quantile(x,0.25),
                        'Skewness':x.skew(),
                        'Kurtosis':x.kurtosis()})

def summary_univariate_cathe(x:pd.Series):
    counts = x.value_counts(dropna=True)
    # modes = stats.mode(x, keepdims=True)
    mode_val = counts.index[0]
    mode_freq = counts.iloc[0]
    summary = pd.Series({'total':len(x),
                        'non-missing': x.notnull().sum(),
                        'missing': x.isnull().sum(),
                        'pct_missing': x.isnull().mean()*100,
                        'unique_cathegories': x.nunique(),
                        'mode': mode_val,#modes.mode[0],
                        'mode_frequency': mode_freq}) #modes.count[0]})
    frequencies = {'cathe':np.array(counts.index),
                    'freq':(counts.values), 
                    'pct': round(counts.values/counts.sum()*100,2)}
    return summary, pd.DataFrame(frequencies)