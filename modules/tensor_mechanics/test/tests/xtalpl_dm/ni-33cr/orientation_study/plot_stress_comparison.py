import numpy as np
from numpy import linalg
from matplotlib import pyplot, rc, patches
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


##  Or:
# data = np.genfromtxt('some_data.csv',delimiter=',',skip_header=1)

offset  = 0.

# Filenames of the input files used in these simulations:
cdd_ni_100_0 = 'Kalidindi_100-001_out.csv'
cdd_ni_100_45 = 'Kalidindi_111-101_out.csv'
cdd_ni_111_101 = 'Kalidindi_211-011_out.csv'
cdd_ni_213_111 = 'Kalidindi_213-111_out.csv'

# Build the array of csv files to read the selected data
files = []
files.append(cdd_ni_100_0)
files.append(cdd_ni_100_45)
files.append(cdd_ni_111_101)
files.append(cdd_ni_213_111)

print "Gathering values from these files: " + ' and '.join(files)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

columns = []
columns.append('pk2_xx')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'e_xx', columns[0])


# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=50, label=r'$[100](001)$ PK2$_{load}$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='teal', marker='s', markevery=50, label=r'$[111](\bar{1}01)$ PK2$_{load}$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='slateblue', marker='v', markevery=50, label=r'$[2\bar{1}1](011)$ PK2$_{load}$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='rosybrown', marker='^', markevery=50, label=r'$[\bar{2}\bar{1}3](111)$ PK2$_{load}$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('PK2 Stress (MPa)')
ax1.set_xlabel('Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')

ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('pk2-Kalidindi-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('stress_xx')
# columns.append('True Stress (Mpa)')
# columns.append('Engineering Stress (Mpa)')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'e_xx', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=50, label=r'$[100](001)$ $\sigma_{load}$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='teal', marker='s', markevery=50, label=r'$[111](\bar{1}01)$ $\sigma_{load}$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='slateblue', marker='v', markevery=50, label=r'$[2\bar{1}1](011)$ $\sigma_{load}$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='rosybrown', marker='^', markevery=50, label=r'$[\bar{2}\bar{1}3](111)$ $\sigma_{load}$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Cauchy Stress (MPa)')
ax1.set_xlabel('Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('cauchy-Kalidindi-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('vonmises_stress_cauchy')
# columns.append('True Stress (Mpa)')
# columns.append('Engineering Stress (Mpa)')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=50, label=r'$[100](001)$ vonMises')
p1 = ax1.plot(xvalue[1], yvalue[1], color='teal', marker='s', markevery=50, label=r'$[111](\bar{1}01)$ vonMises')
p1 = ax1.plot(xvalue[2], yvalue[2], color='slateblue', marker='v', markevery=50, label=r'$[2\bar{1}1](011)$ vonMises')
p1 = ax1.plot(xvalue[3], yvalue[3], color='rosybrown', marker='^', markevery=50, label=r'$[\bar{2}\bar{1}3](111)$ vonMises')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Effective Cauchy Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('vonMises-Kalidindi-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()
