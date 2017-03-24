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
pmdd_all_irr_file = 'cdd_crystal_plasticity_100load_det'

# Generate the names of the postprocessor csv output files
pmdd_all_irr_csv_file = [pmdd_all_irr_file, '_out.csv']

pmdd_all_output_file = ''.join(pmdd_all_irr_csv_file)


# Build the array of csv files to read the selected data
files = []
files.append(pmdd_all_output_file)

print "Gathering values from these files: " + ' and '.join(files)

# #headers of the columns which we want to plot
# columns = []
# columns.append('gss_0')
# columns.append('gss_1')
# columns.append('gss_2')
# columns.append('gss_3')
# columns.append('gss_4')
# columns.append('gss_5')
# columns.append('gss_6')
# columns.append('gss_7')
# columns.append('gss_8')
# columns.append('gss_9')
# columns.append('gss_10')
# columns.append('gss_11')
# columns.append('gss_12')
# columns.append('gss_13')
# columns.append('gss_14')
# columns.append('gss_15')
# columns.append('gss_16')
# columns.append('gss_17')
# columns.append('gss_18')
# columns.append('gss_19')
# columns.append('gss_20')
# columns.append('gss_21')
# columns.append('gss_22')
# columns.append('gss_23')
# print "Data collected: " + ' '.join(columns)

#set a figure number integer for the plots to make sure we get a clean figure for each new plot
fig_number = 1

# #set up x and y lists to match the files
# xvalue = [None] * len(files) * len(columns)
# yvalue = [None] * len(files) * len(columns)
#
# #Loop over the filenames to print out the same values in different folders
# for i in xrange(len(columns)):
#   for j in xrange(len(files)):
#     print j+len(files)*i
#     xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])
#
# # Set up a single plot on a single figure
# pyplot.figure(fig_number)
# ax1= pyplot.subplot(111)
#
# p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
# p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
# p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
# p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
# p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
# p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
# p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
# p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
# p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
# p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
# p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
# p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
# p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
# p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
# p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
# p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
# p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
# p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
# p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
# p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
# p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
# p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
# p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
# p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
#
# ax1.legend(loc=9, numpoints = 1, prop={'size':10}, bbox_to_anchor=(0.5, -0.1), ncol=4)
# #,bbox_to_anchor=(0.5, -0.1),
# #ax1.set_ylim([40,50])
# #ax1.set_xlim([0,0.0025])
#
# ax1.set_ylabel('Slip System Strength (MPa)')
# ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
#
# ax1.set_title('Slip System Strength')
#
# ax1.yaxis.tick_left()
# ax1.tick_params(labeltop='off')
# #ax1.errorbar(x2,y2, yerr=2)
# #[1, 1, 2, 1, 3]
# # don't put tick labels at the top
# #ax11.tick_params(labeltop='off') # don't put tick labels at the top
# #ax22.yaxis.tick_right()
#
# pyplot.subplots_adjust(wspace=0.15)
#
# pyplot.subplots_adjust(bottom=0.12)
# pyplot.subplots_adjust(top=0.9)
# pyplot.subplots_adjust(left=0.12)
# pyplot.subplots_adjust(right=0.88)
#
# pyplot.savefig('slip_system_strength_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)
#
# # Clear the figure of the current plot to make room for a new plot
# pyplot.clf()
#
#
# #headers of the columns which we want to plot
# columns = []
# columns.append('tau_0')
# columns.append('tau_1')
# columns.append('tau_2')
# columns.append('tau_3')
# columns.append('tau_4')
# columns.append('tau_5')
# columns.append('tau_6')
# columns.append('tau_7')
# columns.append('tau_8')
# columns.append('tau_9')
# columns.append('tau_10')
# columns.append('tau_11')
# columns.append('tau_12')
# columns.append('tau_13')
# columns.append('tau_14')
# columns.append('tau_15')
# columns.append('tau_16')
# columns.append('tau_17')
# columns.append('tau_18')
# columns.append('tau_19')
# columns.append('tau_20')
# columns.append('tau_21')
# columns.append('tau_22')
# columns.append('tau_23')
# print "Data collected: " + ' '.join(columns)
#
# #set a figure number integer for the plots to make sure we get a clean figure for each new plot
# fig_number = 1
#
# #set up x and y lists to match the files
# xvalue = [None] * len(files) * len(columns)
# yvalue = [None] * len(files) * len(columns)
#
# #Loop over the filenames to print out the same values in different folders
# for i in xrange(len(columns)):
#   for j in xrange(len(files)):
#     print j+len(files)*i
#     xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])
#
# # Set up a single plot on a single figure
# pyplot.figure(fig_number)
# ax1= pyplot.subplot(111)
#
# p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
# p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
# p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
# p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
# p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
# p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
# p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
# p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
# p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
# p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
# p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
# p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
# p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
# p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
# p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
# p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
# p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
# p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
# p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
# p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
# p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
# p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
# p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
# p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
#
# ax1.legend(loc=9, numpoints = 1, prop={'size':10}, bbox_to_anchor=(0.5, -0.1), ncol=4)
# #ax1.set_xlim([0,0.0025])
# #ax1.set_ylim([40,50])
#
# ax1.set_ylabel('Applied Slip System Stress (Pa)')
# ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
#
# ax1.set_title('Applied Slip System Stress')
#
# ax1.yaxis.tick_left()
# ax1.tick_params(labeltop='off')
# #ax1.errorbar(x2,y2, yerr=2)
# #[1, 1, 2, 1, 3]
# # don't put tick labels at the top
# #ax11.tick_params(labeltop='off') # don't put tick labels at the top
# #ax22.yaxis.tick_right()
#
# pyplot.subplots_adjust(wspace=0.15)
#
# pyplot.subplots_adjust(bottom=0.12)
# pyplot.subplots_adjust(top=0.9)
# pyplot.subplots_adjust(left=0.12)
# pyplot.subplots_adjust(right=0.88)
#
# pyplot.savefig('tau_slip_system_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)
#
# # Clear the figure of the current plot to make room for a new plot
# pyplot.clf()
#
#
# ## Slip increment on active slip system
# #headers of the columns which we want to plot
# columns = []
# columns.append('slip_increment_0')
# columns.append('slip_increment_1')
# columns.append('slip_increment_2')
# columns.append('slip_increment_3')
# columns.append('slip_increment_4')
# columns.append('slip_increment_5')
# columns.append('slip_increment_6')
# columns.append('slip_increment_7')
# columns.append('slip_increment_8')
# columns.append('slip_increment_9')
# columns.append('slip_increment_10')
# columns.append('slip_increment_11')
# columns.append('slip_increment_12')
# columns.append('slip_increment_13')
# columns.append('slip_increment_14')
# columns.append('slip_increment_15')
# columns.append('slip_increment_16')
# columns.append('slip_increment_17')
# columns.append('slip_increment_18')
# columns.append('slip_increment_19')
# columns.append('slip_increment_20')
# columns.append('slip_increment_21')
# columns.append('slip_increment_22')
# columns.append('slip_increment_23')
# print "Data collected: " + ' '.join(columns)
#
# #set a figure number integer for the plots to make sure we get a clean figure for each new plot
# fig_number = 1
#
# #set up x and y lists to match the files
# xvalue = [None] * len(files) * len(columns)
# yvalue = [None] * len(files) * len(columns)
#
# #Loop over the filenames to print out the same values in different folders
# for i in xrange(len(columns)):
#   for j in xrange(len(files)):
#     print j+len(files)*i
#     xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])
#
# # Set up a single plot on a single figure
# pyplot.figure(fig_number)
# ax1= pyplot.subplot(111)
#
# p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
# p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
# p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
# p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
# p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
# p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
# p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
# p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
# p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
# p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
# p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
# p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
# p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
# p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
# p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
# p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
# p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
# p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
# p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
# p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
# p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
# p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
# p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
# p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
#
# ax1.legend(loc=9, numpoints = 1, prop={'size':10}, bbox_to_anchor=(0.5, -0.1), ncol=4)
# #ax1.set_xlim([0,0.0025])
# #ax1.set_ylim([-1.8e-5,0.5e-6])
#
# #ax2.set_ylim([0,40])
#
# ax1.set_ylabel('Slip Increment (mm)')
# ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
# ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
#
# #ax2.set_ylabel("LHR (kW/m)")
#
# ax1.set_title('Slip Increment Among Slip Systems')
#
# ax1.yaxis.tick_left()
# ax1.tick_params(labeltop='off')
# #ax1.errorbar(x2,y2, yerr=2)
# #[1, 1, 2, 1, 3]
# # don't put tick labels at the top
# #ax11.tick_params(labeltop='off') # don't put tick labels at the top
# #ax22.yaxis.tick_right()
#
# pyplot.subplots_adjust(wspace=0.15)
#
# pyplot.subplots_adjust(bottom=0.12)
# pyplot.subplots_adjust(top=0.9)
# pyplot.subplots_adjust(left=0.12)
# pyplot.subplots_adjust(right=0.88)
#
# pyplot.savefig('slip_increment_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)
#
# # Clear the figure of the current plot to make room for a new plot
# pyplot.clf()


##### Now make a new plot of stress vs strain behavior
fig_number = 1 + fig_number
columns = []
columns.append('pk2_xx')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', marker='+', label='Single BCC crystal')

ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
ax1.set_xlim([0,0.00026])
#ax1.set_ylim([0,900])

ax1.set_ylabel('2nd Piola Kirchoff Stress in X-direction (MPa)')
ax1.set_xlabel('Lagrangian  Strain in X-direction (mm/mm)')
ax1.set_title('BCC Single Crystal with Varying Irradiation Damage')

ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('stress-strain_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

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
columns.append('mobile_disl_12')
columns.append('mobile_disl_13')
columns.append('mobile_disl_14')
columns.append('mobile_disl_15')
columns.append('mobile_disl_16')
columns.append('mobile_disl_17')
columns.append('mobile_disl_18')
columns.append('mobile_disl_19')
columns.append('mobile_disl_20')
columns.append('mobile_disl_21')
columns.append('mobile_disl_22')
columns.append('mobile_disl_23')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')

ax1.legend(loc=9, numpoints = 1, prop={'size':10}, bbox_to_anchor=(0.5, -0.1), ncol=4)
ax1.set_xlim([0,0.00026])
# ax1.set_ylim([83000,84200])

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
pyplot.savefig('mobile_dislocations_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')

ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
ax2.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
ax2.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
ax2.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
ax2.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
ax2.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
ax3.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
ax3.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
ax3.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
ax3.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
ax3.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
ax4.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
ax4.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
ax4.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
ax4.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
ax4.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
ax4.legend(loc='upper left', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.tick_params(axis='y', which='major', labelsize=8)
ax1.set_xlim([0,0.00026])
# ax1.set_ylim([83000,84200])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.tick_params(axis='y', which='major', labelsize=8)
ax3.tick_params(axis='x', which='major', labelsize=8)
ax4.set_xlim([0,0.00026])
# ax3.set_ylim([83000,84200])
ax4.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax4.tick_params(axis='x', which='major', labelsize=8)

for tick in ax4.get_xticklabels():
  tick.set_rotation(60)

for tick in ax3.get_xticklabels():
  tick.set_rotation(60)


active_sys_figure.subplots_adjust(hspace=0.2)
pyplot.suptitle('Mobile Dislocation Evolution by Cross Slip Family')
pyplot.savefig('mobile_dislocations_bcc_100load_deterministic_singleElem_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

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
columns.append('immobile_disl_12')
columns.append('immobile_disl_13')
columns.append('immobile_disl_14')
columns.append('immobile_disl_15')
columns.append('immobile_disl_16')
columns.append('immobile_disl_17')
columns.append('immobile_disl_18')
columns.append('immobile_disl_19')
columns.append('immobile_disl_20')
columns.append('immobile_disl_21')
columns.append('immobile_disl_22')
columns.append('immobile_disl_23')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')

ax1.legend(loc=9, numpoints = 1, prop={'size':10}, bbox_to_anchor=(0.5, -0.1), ncol=4)
ax1.set_xlim([0,0.00026])
# ax1.set_ylim([83000,84200])

ax1.set_ylabel('Immobile Dislocation Density (1/mm^2)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('Immobile Dislocation Evolution Among Slip Systems')
ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('immobile_dislocations_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')

ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
ax2.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
ax2.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
ax2.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
ax2.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
ax2.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
ax3.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
ax3.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
ax3.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
ax3.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
ax3.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
ax4.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
ax4.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
ax4.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
ax4.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
ax4.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
ax4.legend(loc='upper left', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.tick_params(axis='y', which='major', labelsize=8)
ax1.set_xlim([0,0.00026])
# ax1.set_ylim([83000, 84200])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.tick_params(axis='y', which='major', labelsize=8)
ax4.set_xlim([0,0.00026])
# ax3.set_ylim([83000, 84200])
ax3.tick_params(axis='x', which='major', labelsize=8)
ax4.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax4.tick_params(axis='x', which='major', labelsize=8)

for tick in ax4.get_xticklabels():
  tick.set_rotation(60)

for tick in ax3.get_xticklabels():
  tick.set_rotation(60)


active_sys_figure.subplots_adjust(hspace=0.2)
pyplot.suptitle('Immobile Dislocation Evolution by Cross Slip Family')
pyplot.savefig('immobile_dislocations_bcc_100load_deterministic_singleElem_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

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
columns.append('cross_slip_disl_12')
columns.append('cross_slip_disl_13')
columns.append('cross_slip_disl_14')
columns.append('cross_slip_disl_15')
columns.append('cross_slip_disl_16')
columns.append('cross_slip_disl_17')
columns.append('cross_slip_disl_18')
columns.append('cross_slip_disl_19')
columns.append('cross_slip_disl_20')
columns.append('cross_slip_disl_21')
columns.append('cross_slip_disl_22')
columns.append('cross_slip_disl_23')
print "Data collected: " + ' '.join(columns)

#set up x and y lists to match the files
xvalue = [None] * len(files) * len(columns)
yvalue = [None] * len(files) * len(columns)

#Loop over the filenames to print out the same values in different folders
for i in xrange(len(columns)):
  for j in xrange(len(files)):
    print j+len(files)*i
    xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])

# Using the matplotlib tutorial now
pyplot.figure(fig_number)
ax1= pyplot.subplot(111)

p1 = ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
p2 = ax1.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
p3 = ax1.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
p4 = ax1.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
p5 = ax1.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
p6 = ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
p7 = ax1.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
p8 = ax1.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
p9 = ax1.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
p10 = ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
p11 = ax1.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
p12 = ax1.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
p13 = ax1.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
p14 = ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
p15 = ax1.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
p16 = ax1.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
p17 = ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
p18 = ax1.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
p19 = ax1.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
p20 = ax1.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
p21 = ax1.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
p22 = ax1.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
p23 = ax1.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
p24 = ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')

ax1.legend(loc=9, numpoints = 1, prop={'size':10},bbox_to_anchor=(0.5, -0.1), ncol=4)
ax1.set_xlim([0,0.00026])
#ax1.set_ylim([1.5e7,5.0e7])

ax1.set_ylabel('Cross Slipped Dislocation Density (1/mm^2)')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.set_xlabel('Lagrangian  Strain (mm/mm)')
ax1.set_title('Cross Slip Dislocation Increment Among Slip Systems')
ax1.yaxis.tick_left()
ax1.tick_params(labeltop='off')

pyplot.subplots_adjust(wspace=0.15)
pyplot.subplots_adjust(bottom=0.12)
pyplot.subplots_adjust(top=0.9)
pyplot.subplots_adjust(left=0.12)
pyplot.subplots_adjust(right=0.88)
pyplot.savefig('xslip_dislocations_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()

## Now let's make some subplot-ed plots examining the correlated values among slip systems
active_sys_figure, ((ax1, ax2), (ax3, ax4)) = pyplot.subplots(2, 2, sharex='col', sharey='row')

ax1.plot(xvalue[0], yvalue[0], color='firebrick', linestyle='-', label='(0 1 1)[1 -1 1] system')
ax1.plot(xvalue[5], yvalue[5], color='darkgreen', linestyle=':', label='(1 1 0)[1 -1 1] system')
ax1.plot(xvalue[9], yvalue[9], color='blue', linestyle='--', label='(1 0 -1)[1 -1 1] system')
ax1.plot(xvalue[13], yvalue[13], color='mediumpurple', linestyle='-.', label='(-1 1 2)[1 -1 1] system')
ax1.plot(xvalue[16], yvalue[16], color='saddlebrown', linestyle='-.', label='(1 2 1)[1 -1 1] system')
ax1.plot(xvalue[23], yvalue[23], color='salmon', linestyle=':', label='(2 1 -1)[1 -1 1] system')
ax1.legend(loc='best', numpoints = 1, prop={'size':8})

ax2.plot(xvalue[1], yvalue[1], color='maroon', linestyle='-.', label='(0 1 1)[1 1 -1] system')
ax2.plot(xvalue[3], yvalue[3], color='seagreen', linestyle= '--', label='(1 0 1)[1 1 -1] system')
ax2.plot(xvalue[11], yvalue[11], color='royalblue', linestyle=':', label='(-1 1 0)[1 1 -1] system')
ax2.plot(xvalue[12], yvalue[12], color='darkviolet', linestyle='-', label='(1 1 2)[1 1 -1] system')
ax2.plot(xvalue[17], yvalue[17], color='olive', linestyle=':', label='(-1 2 1)[1 1 -1] system')
ax2.plot(xvalue[22], yvalue[22], color='mediumorchid', linestyle='--', label='(2 -1 1)[1 1 -1] system')
ax2.legend(loc='best', numpoints = 1, prop={'size':8})

ax3.plot(xvalue[2], yvalue[2], color='crimson', linestyle=':', label='(1 0 1)[-1 1 1] system')
ax3.plot(xvalue[4], yvalue[4], color='darkolivegreen', linestyle='-.', label='(1 1 0)[-1 1 1] system')
ax3.plot(xvalue[7], yvalue[7], color='cornflowerblue', linestyle='--', label='(0 -1 1)[-1 1 1] system')
ax3.plot(xvalue[14], yvalue[14], color='indigo', linestyle=':', label='(1 -1 2)[-1 1 1] system')
ax3.plot(xvalue[19], yvalue[19], color='darkgoldenrod', linestyle='--', label='(1 2 -1)[-1 1 1] system')
ax3.plot(xvalue[20], yvalue[20], color='mediumvioletred', linestyle='-', label='(2 1 1)[-1 1 1] system')
ax3.legend(loc='best', numpoints = 1, prop={'size':8})

ax4.plot(xvalue[6], yvalue[6], color='indianred', linestyle='-', label='(0 -1 1)[1 1 1] system')
ax4.plot(xvalue[8], yvalue[8], color='teal', linestyle='-', label='(1 0 -1)[1 1 1] system')
ax4.plot(xvalue[10], yvalue[10], color='steelblue', linestyle='-.', label='(-1 1 0)[1 1 1] system')
ax4.plot(xvalue[15], yvalue[15], color='slateblue', linestyle= '--', label='(1 1 -2)[1 1 1] system')
ax4.plot(xvalue[18], yvalue[18], color='sienna', linestyle='-', label='(1 -2 1)[1 1 1] system')
ax4.plot(xvalue[21], yvalue[21], color='palevioletred', linestyle='-.', label='(-2 1 1)[1 1 1] system')
ax4.legend(loc='upper left', numpoints = 1, prop={'size':8})

ax1.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax1.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax1.tick_params(axis='y', which='major', labelsize=8)
ax1.set_xlim([0,0.00026])
#ax1.set_ylim([2.5e7, 3.5e7])
ax3.set_ylabel('Dislocation Density (1/mm^2)', fontsize='small')
ax3.set_xlabel('Lagrangian  Strain (mm/mm)', fontsize='small')
ax3.yaxis.set_major_formatter(mtick.FormatStrFormatter('%.1e'))
ax3.tick_params(axis='y', which='major', labelsize=8)
ax4.set_xlim([0,0.00026])
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
pyplot.savefig('xslip_dislocations_bcc_100load_deterministic_singleElem_active_systems_comparison.pdf',bbox_inches='tight',pad_inches=0.1)

# Close all of the open figures
pyplot.close()


# ##### Now make a new plot of SIA loop density vs strain evolution
# fig_number = 1 + fig_number
# columns = []
# columns.append('scalar_damage_loops')
# print "Data collected: " + ' '.join(columns)
#
# #set up x and y lists to match the files
# xvalue = [None] * len(files) * len(columns)
# yvalue = [None] * len(files) * len(columns)
#
# #Loop over the filenames to print out the same values in different folders
# for i in xrange(len(columns)):
#   for j in xrange(len(files)):
#     print j+len(files)*i
#     xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])
#
# # Using the matplotlib tutorial now
# pyplot.figure(fig_number)
# ax1= pyplot.subplot(111)
#
# p1 = ax1.plot(xvalue[0], yvalue[0], color='steelblue', label='Scalar SIA loop density')
#
# #ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
# #ax1.set_xlim([0,0.0025])
# #ax1.set_ylim([0,900])
#
# ax1.set_ylabel('Scalar Measure of SIA Loop Density(1/mm^3)')
# ax1.set_xlabel('Lagrangian  Strain in X-direction (mm/mm)')
# ax1.set_title('Evolution of SIA Loop Density in a BCC Single Crystal')
#
# ax1.yaxis.tick_left()
# ax1.tick_params(labeltop='off')
#
# pyplot.subplots_adjust(wspace=0.15)
# pyplot.subplots_adjust(bottom=0.12)
# pyplot.subplots_adjust(top=0.9)
# pyplot.subplots_adjust(left=0.12)
# pyplot.subplots_adjust(right=0.88)
# pyplot.savefig('sia_loop_evolution_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)
#
# # Close all of the open figures
# pyplot.close()
#
#
# ##### Now make a new plot of SIA loop caused resistance vs strain evolution
# fig_number = 1 + fig_number
# columns = []
# columns.append('sia_loop_resistance')
# print "Data collected: " + ' '.join(columns)
#
# #set up x and y lists to match the files
# xvalue = [None] * len(files) * len(columns)
# yvalue = [None] * len(files) * len(columns)
#
# #Loop over the filenames to print out the same values in different folders
# for i in xrange(len(columns)):
#   for j in xrange(len(files)):
#     print j+len(files)*i
#     xvalue[j+len(files)*i], yvalue[j+len(files)*i] = readTimeSeries(files[j], 'e_xx', columns[i])
#
# # Using the matplotlib tutorial now
# pyplot.figure(fig_number)
# ax1= pyplot.subplot(111)
#
# p1 = ax1.plot(xvalue[0], yvalue[0], color='teal', label='Scalar SIA Loop Slip System Resistance')
#
# #ax1.legend(loc='lower right', numpoints = 1, prop={'size':10})
# #ax1.set_xlim([0,0.0025])
# ax1.set_ylim([0,1e-11])
#
# ax1.set_ylabel('Component of Resistance from SIA Loop Density(MPa)')
# ax1.set_xlabel('Lagrangian  Strain in X-direction (mm/mm)')
# ax1.set_title('SIA Loops Resistance Contribution')
#
# ax1.yaxis.tick_left()
# ax1.tick_params(labeltop='off')
#
# pyplot.subplots_adjust(wspace=0.15)
# pyplot.subplots_adjust(bottom=0.12)
# pyplot.subplots_adjust(top=0.9)
# pyplot.subplots_adjust(left=0.12)
# pyplot.subplots_adjust(right=0.88)
# pyplot.savefig('sia_loop_resistance_bcc_100load_deterministic_singleElem_comparison.pdf',bbox_inches='tight',pad_inches=0.1)
#
# # Close all of the open figures
# pyplot.close()
