import matplotlib.pyplot as plt
import seaborn as sns

from numpy import *
from scipy.stats import norm


def set_sns():
	sns.set()
	
def plot_normal_adjmnt(df, var_name, axlabel=None, fct=None):
	values = df[var_name]
	if not axlabel:
		axlabel = var_name
	if fct:
		values = fct(values)
	g=sns.distplot(values, axlabel=axlabel.format(var_name))
	x = linspace(min(values), max(values), 1000)
	y = norm.pdf(x, mean(values), std(values))
	g.plot(x, y,'red', label="Normal adj")
	g.legend(bbox_to_anchor=(0.79, 0.95), loc='upper left', borderaxespad=0.)

def plot_normal_adjmnt_comparison(df, var_name, width, height, fct):
	set_sns()
	fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(width, height))
	plt.subplot(121)
	plot_normal_adjmnt(df, var_name)	
	plt.subplot(122)
	plot_normal_adjmnt(df, var_name, 'log1p({})', fct)	
	plt.show()