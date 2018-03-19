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
cdd_ni_100_0 = 'cdd_100-0load_ni_out.csv'
cdd_ni_100_45 = 'cdd_100-45load_ni_out.csv'
cdd_ni_111_101 = 'cdd_111-101load_ni_out.csv'
cdd_ni_111_121 = 'cdd_111-121load_ni_out.csv'
cdd_ni_21bar1 = 'cdd_21bar1load_ni_out.csv'
cdd_ni_21bar1_111bar = 'cdd_21bar1-111load_ni_out.csv'
cdd_ni_2bar1bar3 = 'cdd_2bar1bar3load_ni_out.csv'
# exp_data_alphaFe = 'lambrecht2008-alphaFe-unirradiated.csv'

# Build the array of csv files to read the selected data
files = []
files.append(cdd_ni_100_0)
files.append(cdd_ni_100_45)
files.append(cdd_ni_111_101)
files.append(cdd_ni_111_121)
files.append(cdd_ni_21bar1)
files.append(cdd_ni_21bar1_111bar)
files.append(cdd_ni_2bar1bar3)
# files.append(exp_data_alphaFe)

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

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # PK2$_{load}$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # PK2$_{load}$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Stress (MPa)')
ax1.set_xlabel('Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')

ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('pk2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

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
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

#Loop over the filenames to print out the same values in different folders
for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # vonMises PK2')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # vonMises PK2')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # vonMises PK2')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # vonMises PK2')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # vonMises PK2')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # vonMises PK2')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # vonMises PK2')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Effective Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('vonMises-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()



######################################################
# Slip System 0
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_0')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl on $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_0')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_0')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_0')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_0')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_0')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[011](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[011](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys0-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()



######################################################
# Slip System 1
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_1')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl on $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_1')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_1')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_1')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_1')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # v$\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_1')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[101](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[101](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys1-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 2
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_2')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[1\bar{1}0](11\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys2-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 3
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_3')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_3')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[01\bar{1}](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_3')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[01\bar{1}](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_3')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[01\bar{1}](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_3')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[01\bar{1}](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_3')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[01\bar{1}](1\bar{1}\bar{1})$')


ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys3-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 4
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_4')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_4')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_4')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_4')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_4')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_4')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[101](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[101](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys4-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 5
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_5')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_5')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_5')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_5')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_5')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_5')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[110](1\bar{1}\bar{1})$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[110](1\bar{1}\bar{1})$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys5-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 6
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_6')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_6')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_6')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_6')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_6')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_6')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[011](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[011](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys6-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 7
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_7')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_7')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_7')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_7')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_7')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_7')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[10\bar{1}](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys7-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 8
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_8')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_8')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_8')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_8')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_8')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_8')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[110](1\bar{1}1)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[110](1\bar{1}1)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys8-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 9
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_9')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_9')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_9')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_9')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_9')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_9')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[01\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[01\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys9-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()



######################################################
# Slip System 10
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_10')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_10')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_10')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_10')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_10')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_10')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[10\bar{1}](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[10\bar{1}](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys10-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


######################################################
# Slip System 11
#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('mobile_disl_11')
print "Data collected: " + ' '.join(columns)

xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Mobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Mobile Disl $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Mobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobileDisl-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('immobile_disl_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Immobile Disl $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Immobile Disl $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Immobile Dislocation Density (1/mm$^2$)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobileDisl-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('tau_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\tau$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\tau$ on $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Applied Resolved Shear Stress (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('appliedStress-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('glide_velocity_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Glide Velocity $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Glide Velocity $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Dislocation Glide Velocity (mm/s)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('glideVelocity-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('slip_increment_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # $\Delta \gamma$ on $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip Increment (1/mm)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('slipIncrement-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = fig_number + 1

columns = []
columns.append('gss_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * (len(files))
yvalue = [None] * (len(files))

for j in xrange(len(files)):
  print j
  xvalue[j], yvalue[j] = readTimeSeries(files[j], 'effective_strain', columns[0])

pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='sienna', marker='o', markevery=100, label=r'$[100](001)$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[1], yvalue[1], color='darkgoldenrod', label=r'$[100](011)$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[2], yvalue[2], color='teal', marker='s', markevery=100, label=r'$[111](\bar{1}01)$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[3], yvalue[3], color='lightseagreen', label=r'$[111](1\bar{2}1)$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[4], yvalue[4], color='slateblue', marker='v', markevery=100, label=r'$[2\bar{1}1](011)$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[5], yvalue[5], color='mediumpurple', label=r'$[2\bar{1}1](11\bar{1})$') # Slip Resistance $[1\bar{1}0](111)$')
p1 = ax1.plot(xvalue[6], yvalue[6], color='rosybrown', label=r'$[\bar{2}\bar{1}3](111)$') # Slip Resistance $[1\bar{1}0](111)$')

ax1.legend(loc='best', numpoints = 1, prop={'size':12})
# ax1.set_xlim([0,0.1])
# ax1.set_ylim([0,300])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Effective Strain (mm/mm)')
#ax1.set_title('Comparison of Simulation Loading Directions, FCC Ni')
ax1.tick_params(labeltop='off', left='on', right='on', direction='in')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('systemStrength-sys11-simulation-loadingDir-comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()
