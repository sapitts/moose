import numpy as np
from numpy import linalg
from matplotlib import pyplot, rc, patches

#rc('text', usetex=True)
#rc('text.latex', preamble = ','.join('''
#\usepackage{txfonts}
#\usepackage{siunitx}
#'''.split()))
#rc('font', **{'family':'serif','serif':['Times'],'size':10})

def readTimeSeries( filename, field1, field2 ):
  with open( filename, 'r' ) as f:
    header = f.readline().split(',')
  field1_index = header.index(field1)
  #x_index = header.index()
  field2_index = header.index(field2)
  raw = np.genfromtxt( filename, delimiter=',' )[1:,:]
  field1 = raw[:,field1_index]
  field2 = raw[:,field2_index]
  return field1, field2

offset  = 0.

# Filenames of the input files used in these simulations:
pmdd_all_irr_file = 'cdd_crystal_plasticity_temp'

# Generate the names of the postprocessor csv output files
pmdd_all_irr_csv_file = [pmdd_all_irr_file, '_out.csv']

pmdd_all_output_file = ''.join(pmdd_all_irr_csv_file)


# Build the array of csv files to read the selected data
files = []
files.append(pmdd_all_output_file)

print "Gathering values from these files: " + ' and '.join(files)

#headers of the columns which we want to plot
columns = []
columns.append('gss_0')
columns.append('gss_1')
columns.append('gss_2')
columns.append('gss_3')
columns.append('gss_4')
columns.append('gss_5')
columns.append('gss_6')
columns.append('gss_7')
columns.append('gss_8')
columns.append('gss_9')
columns.append('gss_10')
columns.append('gss_11')
print "Data collected: " + ' '.join(columns)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Set up a single plot on a single figure
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')


ax1.legend(loc='best', numpoints = 1, prop={'size':10})
#ax1.set_ylim([40,50])
#ax1.set_xlim([0,0.0035])

ax1.set_ylabel('Slip System Strength (MPa)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')

ax1.set_title('Slip System Strength')

ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')
#ax1.errorbar(x2,y2, yerr=2)
#[1, 1, 2, 1, 3]
# don't put tick labels at the top
#ax11.tick_params(labeltop='off') # don't put tick labels at the top
#ax22.yaxis.tick_right()

pyplot.subplots_adjust(wspace=0.15)

pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)

pyplot.savefig('slip_system_strength_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Clear the figure of the current plot to make room for a new plot
pyplot.clf()


#headers of the columns which we want to plot
columns = []
columns.append('tau_0')
columns.append('tau_1')
columns.append('tau_2')
columns.append('tau_3')
columns.append('tau_4')
columns.append('tau_5')
columns.append('tau_6')
columns.append('tau_7')
columns.append('tau_8')
columns.append('tau_9')
columns.append('tau_10')
columns.append('tau_11')
print "Data collected: " + ' '.join(columns)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Set up a single plot on a single figure
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')


ax1.legend(loc='best', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0018])
#ax1.set_ylim([40,50])

ax1.set_ylabel('Applied Slip System Stress (Pa)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')

ax1.set_title('Applied Slip System Stress')

ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')
#ax1.errorbar(x2,y2, yerr=2)
#[1, 1, 2, 1, 3]
# don't put tick labels at the top
#ax11.tick_params(labeltop='off') # don't put tick labels at the top
#ax22.yaxis.tick_right()

pyplot.subplots_adjust(wspace=0.15)

pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)

pyplot.savefig('tau_slip_system_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Clear the figure of the current plot to make room for a new plot
pyplot.clf()


## Slip increment on active slip system
#headers of the columns which we want to plot
columns = []
columns.append('slip_increment_0')
columns.append('slip_increment_1')
columns.append('slip_increment_2')
columns.append('slip_increment_3')
columns.append('slip_increment_4')
columns.append('slip_increment_5')
columns.append('slip_increment_6')
columns.append('slip_increment_7')
columns.append('slip_increment_8')
columns.append('slip_increment_9')
columns.append('slip_increment_10')
columns.append('slip_increment_11')
print "Data collected: " + ' '.join(columns)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Set up a single plot on a single figure
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')


ax1.legend(loc='best', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0035])
#ax1.set_ylim([-1.8e-5,0.5e-6])

#ax2.set_ylim([0,40])

ax1.set_ylabel('Slip Increment (mm)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')

#ax2.set_ylabel("LHR (kW/m)")

ax1.set_title('Slip Increment Among Slip Systems')

ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')
#ax1.errorbar(x2,y2, yerr=2)
#[1, 1, 2, 1, 3]
# don't put tick labels at the top
#ax11.tick_params(labeltop='off') # don't put tick labels at the top
#ax22.yaxis.tick_right()

pyplot.subplots_adjust(wspace=0.15)

pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)

pyplot.savefig('slip_increment_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Clear the figure of the current plot to make room for a new plot
pyplot.clf()


##### Now make a new plot of stress vs strain behavior
fig_number = 1 + fig_number
columns = []
columns.append('pk2')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', marker='+', label='Single FCC crystal')

ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0035])
#ax1.set_ylim([0,900])

ax1.set_ylabel('2nd Piola Kirchoff Stress (MPa)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('BCC Single Crystal with Varying Irradiation Damage')

ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('stress-strain_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


##### Now make a new plot of mobile dislocation density
fig_number = 1 + fig_number
columns = []
columns.append('mobile_disl_0')
columns.append('mobile_disl_1')
columns.append('mobile_disl_2')
columns.append('mobile_disl_3')
columns.append('mobile_disl_4')
columns.append('mobile_disl_5')
columns.append('mobile_disl_6')
columns.append('mobile_disl_7')
columns.append('mobile_disl_8')
columns.append('mobile_disl_9')
columns.append('mobile_disl_10')
columns.append('mobile_disl_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')

ax1.legend(loc='lower left', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0035])
#ax1.set_ylim([1.5e7,5.0e7])

ax1.set_ylabel('Mobile Dislocation Density (1/mm^2)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('Mobile Dislocation Evolution Among Slip Systems')
ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('mobile_dislocations_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')

ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
ax2.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
ax3.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
ax4.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
ax4.legend(loc='best', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.tick_params(axis='y', which='major', labelsize=8)
#ax1.set_ylim([1.9e7,2.1e7])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.tick_params(axis='y', which='major', labelsize=8)
ax3.tick_params(axis='x', which='major', labelsize=8)
#ax3.set_ylim([1.9e7,2.1e7])

ax4.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax4.tick_params(axis='x', which='major', labelsize=8)

for tick in ax4.get_xticklabels():
  tick.set_rotation(60)

for tick in ax3.get_xticklabels():
  tick.set_rotation(60)


active_sys_figure.subplots_adjust(hspace=0.2)
pyplot.suptitle('Mobile Dislocation Evolution by Cross Slip Family')
pyplot.savefig('mobile_dislocations_fcc_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


##### Now make a new plot of immobile dislocation density
fig_number = 1 + fig_number
columns = []
columns.append('immobile_disl_0')
columns.append('immobile_disl_1')
columns.append('immobile_disl_2')
columns.append('immobile_disl_3')
columns.append('immobile_disl_4')
columns.append('immobile_disl_5')
columns.append('immobile_disl_6')
columns.append('immobile_disl_7')
columns.append('immobile_disl_8')
columns.append('immobile_disl_9')
columns.append('immobile_disl_10')
columns.append('immobile_disl_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')

ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0035])
#ax1.set_ylim([1.5e7,5.0e7])

ax1.set_ylabel('Immobile Dislocation Density (1/mm^2)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('Immobile Dislocation Evolution Among Slip Systems')
ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobile_dislocations_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')


ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
ax2.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
ax3.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
ax4.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
ax4.legend(loc='best', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.tick_params(axis='y', which='major', labelsize=8)
#ax1.set_ylim([2.5e7, 3.5e7])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.tick_params(axis='y', which='major', labelsize=8)
#ax3.set_ylim([2.5e7, 3.5e7])
ax3.tick_params(axis='x', which='major', labelsize=8)
ax4.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax4.tick_params(axis='x', which='major', labelsize=8)

for tick in ax4.get_xticklabels():
  tick.set_rotation(60)

for tick in ax3.get_xticklabels():
  tick.set_rotation(60)


active_sys_figure.subplots_adjust(hspace=0.2)
pyplot.suptitle('Immobile Dislocation Evolution by Cross Slip Family')
pyplot.savefig('immobile_dislocations_fcc_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

##### Now make a new plot of immobile dislocation density
fig_number = 1 + fig_number
columns = []
columns.append('cross_slip_disl_0')
columns.append('cross_slip_disl_1')
columns.append('cross_slip_disl_2')
columns.append('cross_slip_disl_3')
columns.append('cross_slip_disl_4')
columns.append('cross_slip_disl_5')
columns.append('cross_slip_disl_6')
columns.append('cross_slip_disl_7')
columns.append('cross_slip_disl_8')
columns.append('cross_slip_disl_9')
columns.append('cross_slip_disl_10')
columns.append('cross_slip_disl_11')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_zz', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
p2 = ax1.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
p3 = ax1.plot(xvalue[2], yvalue[2], color='darkgoldenrod', linestyle=':', label='slip system 2')
p4 = ax1.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
p5 = ax1.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
p6 = ax1.plot(xvalue[5], yvalue[5], color='red', linestyle=':', label='slip system 5')
p7 = ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
p8 = ax1.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
p9 = ax1.plot(xvalue[8], yvalue[8], color='darkorange', linestyle=':', label='slip system 8')
p10 = ax1.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
p11 = ax1.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
p12 = ax1.plot(xvalue[11], yvalue[11], color='darkorchid', linestyle=':', label='slip system 11')

ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
#ax1.set_xlim([0,0.0035])
#ax1.set_ylim([1.5e7,5.0e7])

ax1.set_ylabel('Immobile Dislocation Density (1/mm^2)')
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('Cross Slip Dislocation Increment Among Slip Systems')
ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('xslip_dislocations_fcc_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')


ax1.plot(xvalue[0], yvalue[0], color='maroon', linestyle='-', label='slip system 0')
ax1.plot(xvalue[6], yvalue[6], color='blue', linestyle='-', label='slip system 6')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[3], yvalue[3], color='darkgreen', linestyle= '--', label='slip system 3')
ax2.plot(xvalue[9], yvalue[9], color='teal', linestyle='--', label='slip system 9')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[1], yvalue[1], color='deepskyblue', linestyle='-.', label='slip system 1')
ax3.plot(xvalue[4], yvalue[4], color='black', linestyle='-.', label='slip system 4')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[7], yvalue[7], color='green', linestyle='--', label='slip system 7')
ax4.plot(xvalue[10], yvalue[10], color='slategray', linestyle='--', label='slip system 10')
ax4.legend(loc='best', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.tick_params(axis='y', which='major', labelsize=8)
#ax1.set_ylim([2.5e7, 3.5e7])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.tick_params(axis='y', which='major', labelsize=8)
#ax3.set_ylim([2.5e7, 3.5e7])
ax3.tick_params(axis='x', which='major', labelsize=8)
ax4.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax4.tick_params(axis='x', which='major', labelsize=8)

for tick in ax4.get_xticklabels():
  tick.set_rotation(60)

for tick in ax3.get_xticklabels():
  tick.set_rotation(60)


active_sys_figure.subplots_adjust(hspace=0.2)
pyplot.suptitle('Cross Slipped Dislocation Increment by Cross Slip Family')
pyplot.savefig('xslip_dislocations_fcc_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()
