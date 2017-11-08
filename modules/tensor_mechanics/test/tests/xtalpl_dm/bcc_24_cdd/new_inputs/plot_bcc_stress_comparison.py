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
  raw = np.genfromtxt( filename, delimiter=',' )[2:,:]
  field1 = raw[:,field1_index]
  field2 = raw[:,field2_index]
  return field1, field2


##  Or:
# data = np.genfromtxt('some_data.csv',delimiter=',',skip_header=1)

offset  = 0.

# Filenames of the input files used in these simulations:
cdd_alphaFe_348 = 'cdd_100load_stochastic_out.csv'
cdd_alphaFe_011 = 'cdd_100load_low_disl_stochastic_out.csv'
cdd_alphaFe_100 = 'cdd_100load_no_xslip_out.csv'
cdd_alphaFe_Vo = 'cdd_100load_calculatVo_stochastic_out.csv'
# exp_data_alphaFe = 'lambrecht2008-alphaFe-unirradiated.csv'

# Build the array of csv files to read the selected data
files = []
files.append(cdd_alphaFe_348)
files.append(cdd_alphaFe_011)
files.append(cdd_alphaFe_100)
files.append(cdd_alphaFe_Vo)
# files.append(exp_data_alphaFe)

print "Gathering values from these files: " + ' and '.join(files)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

columns = []
columns.append('pk2_xx')
# columns.append('True Stress (Mpa)')
# columns.append('Engineering Stress (Mpa)')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files) + 1)
yvalue = [None] * (len(files) + 1)

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files) + 1):
  print j
  if j < 4:
    xvalue[j], yvalue[j] = readTimeSeries(files[j], 'e_xx', columns[0])
  # elif j < 5:
  #   xvalue[j], yvalue[j] = readTimeSeries(files[j], 'True strain', columns[1])
  # else:
  #   xvalue[j], yvalue[j] = readTimeSeries(files[j - 1], 'engineering_strain', columns[2])


# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='grey', marker='o', markevery=500, label='100 loading, 6e6 disl, PK2$_{xx}$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='goldenrod', label='100 loading, 2.5e5 disl, PK2$_{xx}$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', label='100 loading, 6e6 disl no xslip, PK2$_{xx}$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='steelblue', label='100 loading, 6e6 disl calc V$_o$, PK2$_{xx}$')
# p1 = ax1.plot(xvalue[3], yvalue[3], color='blue', marker='o', label='Lambrecht (2008), True Stress')
# p1 = ax1.plot(xvalue[4], yvalue[4], color='navy', marker='s', label='Lambrecht (2008), Engineering Stress')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Stress (MPa)')
ax1.set_xlabel('Strain (mm/mm)')
ax1.set_title('Comparison of Simulation Loading Directions, Alpha Fe')

ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('pk2xx-simulation-100loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('vonmises_stress_pk2')
# columns.append('True Stress (Mpa)')
# columns.append('Engineering Stress (Mpa)')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files) + 1)
yvalue = [None] * (len(files) + 1)

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files) + 1):
  print j
  if j < 4:
    xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])
  # elif j < 5:
  #   xvalue[j], yvalue[j] = readTimeSeries(files[j], 'True strain', columns[1])
  # else:
  #   xvalue[j], yvalue[j] = readTimeSeries(files[j - 1], 'engineering_strain', columns[2])


# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='grey', marker='o', markevery=500,label='100 loading, 6e6 disl, vonMises PK2')
p1 = ax1.plot(xvalue[1], yvalue[1], color='goldenrod', label='100 loading, 2.5e5 disl, vonMises PK2')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', label='100 loading, 6e6 disl no xslip, vonMises PK2')
p1 = ax1.plot(xvalue[3], yvalue[3], color='steelblue', label='100 loading, 6e6 disl calc V$_o$, vonMises PK2')
# p1 = ax1.plot(xvalue[3], yvalue[3], color='blue', marker='o', label='Lambrecht (2008), True Stress')
# p1 = ax1.plot(xvalue[4], yvalue[4], color='navy', marker='s', label='Lambrecht (2008), Engineering Stress')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Stress (MPa)')
ax1.set_xlabel('Strain (mm/mm)')
ax1.set_title('Comparison of Simulation Loading Directions, Alpha Fe')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('vonMises-pk2-simulation-100loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()
