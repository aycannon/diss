'''
Importing data from STATA (not directly).
We want to measure the proportion of price changes that were positive for all given periods.
We have created indicator variables in STATA which show whether there was an increase (1) or decrease (0) in average home price for the region
'''

import pandas as pd
pd.options.display.float_format = '{:,.2f}'.format
import numpy as np
import matplotlib.pyplot as plt
import os
os.chdir('/Users/acannon/Desktop/UoE/4/diss')
import seaborn as sns
sns.set_theme()
sns.set_palette('colorblind')
import warnings
warnings.filterwarnings('ignore')