import numpy as np
from numpy import linalg
from matplotlib import pyplot, rc, patches
from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset
import matplotlib.ticker as mtick

def readTimeSeries( filename, field1, field2 ):
  with open( filename, 'r' ) as f:
    header = f.readline().strip().split(',')
  field1_index = header.index(field1)
  #x_index = header.index()
  field2_index = header.index(field2)
  raw = np.genfromtxt( filename, delimiter=',' )[1:,:]
  field1 = raw[:,field1_index]
  field2 = raw[:,field2_index]
  return field1, field2

data = np.genfromtxt('cdd_111load_ni33cr_with_twins_out.csv', delimiter=',', skip_header=0,
                      skip_footer=0, names=['effective_strain', 'vonmises_stress_pk2', 'twin_volume_fraction'])


##  Or:
# data = np.genfromtxt('some_data.csv',delimiter=',',skip_header=1)

offset  = 0.0

# Filenames of the input files used in these simulations:
file = 'cdd_111load_ni33cr_with_twins_out.csv'

print "Gathering values from these files: " + file

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

columns = []
columns.append('vonmises_stress_pk2')
columns.append('twin_volume_fraction')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(columns)
yvalue = [None] * len(columns)

for j in xrange(len(columns)):
  xvalue[j], yvalue[j] = readTimeSeries(file, 'effective_strain', columns[j])

figure, ax1 = pyplot.subplots()

ax1.plot(xvalue[0], yvalue[0], color='forestgreen', label=r'vonMises PK2 Stress')

ax1.set_ylabel('Effective PK2 Stress (MPa)', color='forestgreen')
ax1.tick_params(labeltop=False, left=True, right=False, direction='in')
ax1.tick_params(axis='y', labelcolor='forestgreen')

ax2 = ax1.twinx()  # instantiate a second axes that shares the same x-axis
ax2.plot(xvalue[1], yvalue[1], color='blue', label=r'Twinned Crystal')
ax2.set_ylabel('Volume Fraction of Twins', color='blue')
ax2.tick_params(axis='y', labelcolor='blue', direction='in', right=True)

ax1.set_xlabel('Effective Strain (mm/mm)')
ax1.set_title(r'FCC Ni$_2$Cr, Loaded along $[111]$ in Tension')
# ax1.legend(loc='best', numpoints = 1, prop={'size':12}) #, ncol=1, bbox_to_anchor=(0.5, -0.1)
# ax1.set_xlim([0,0.1])

axins1 = zoomed_inset_axes(ax1, 3.0, loc='upper center')
axins1.plot(xvalue[0], yvalue[0], color='forestgreen')
axins1.set_xlim([0.00125, 0.00145])
axins1.set_ylim([250, 300])
axins1.tick_params(label1On=False, label2On=False, direction='in')

# axins2 = axins1.twinx()
# axins2 = zoomed_inset_axes(ax2, 3.0, loc='upper center')
# axins2.plot(xvalue[1], yvalue[1], color='blue')
# axins2.set_xlim([0.00125, 0.00145])
# axins2.set_ylim([0.025, 0.03])
# axins2.tick_params(label1On=False, label2On=False, direction='in')

mark_inset(ax1, axins1, loc1=2, loc2=4, fc="none", ec="0.5")

figure.tight_layout()
pyplot.savefig('comparison_pk2stress_twinning_111tension_modelni2cr.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()
