import matplotlib as mpl
import numpy as np
from mpl_toolkits.axes_grid1.inset_locator import mark_inset
from mpl_toolkits.axes_grid1.inset_locator import inset_axes
import matplotlib.ticker as mtick
import matplotlib.pyplot as plt

data = np.genfromtxt('cdd_100load_compression_ni33cr_with_twins_out.csv', delimiter=',', names=True)

fig = plt.figure()
ax1 = fig.add_subplot(111)
mpl.rcParams.update({'font.size': 14})

ln1=ax1.plot(data['effective_strain'], data['vonmises_stress_pk2'], 'darkgreen', label=r'vonMises PK2 Stress')

ax2 = ax1.twinx()  # instantiate a second axes that shares the same x-axis
ln2 = ax2.plot(data['effective_strain'], data['twin_volume_fraction'], color='mediumblue', label=r'Twinned Volume Fraction')


ax1.set_xlabel('Effective Strain (mm/mm)', fontsize=16)
ax1.set_ylabel('Effective PK2 Stress (MPa)', color='darkgreen', fontsize=16)
ax1.tick_params(labeltop=False, left=True, right=False, direction='in')
ax1.tick_params(axis='y', labelcolor='darkgreen')
ax1.set_title(r'FCC Ni$_2$Cr, Loaded along $[100]$ in Compression')

ax2.set_ylabel('Volume Fraction of Twins', color='mediumblue', fontsize=16)
ax2.tick_params(axis='y', labelcolor='mediumblue', direction='in', right=True, labelsize=10)


ax1ins=inset_axes(ax1, width=1.75, height=1.25, loc='upper left', borderpad=1, bbox_to_anchor=(0.175, 0.95), bbox_transform=ax1.figure.transFigure)
ax1ins.plot(data['effective_strain'], data['vonmises_stress_pk2'], color='darkgreen', label=r'vonMises PK2 Stress')
ax2ins=ax1ins.twinx()
ax2ins.plot(data['effective_strain'], data['twin_volume_fraction'], color='mediumblue', label=r'Twinned Volume Fraction')

ax1ins.set_xlim([0.000825, 0.00095])
ax1ins.set_ylim([175, 200])
# ax2ins.set_ylim([0.0, 0.0175])
# ax1ins.xaxis.set_ticks(np.arange(0.00085, 0.00095, 0.0001))
ax1ins.get_xaxis().get_major_formatter().set_useOffset(False)
ax1ins.tick_params(labelsize=10)
ax1ins.tick_params(axis='y', labelcolor='darkgreen')
ax2ins.tick_params(labelsize=10, labelcolor='mediumblue')
mark_inset(ax1, ax1ins, loc1=2, loc2=4, fc="none", ec="0.5")

lines = ln1+ln2
labels = [l.get_label() for l in lines]
ax1.legend(lines, labels, loc='upper center', fontsize=10, numpoints=1, bbox_to_anchor=(0.5, 0.2))

ax1.tick_params(axis='x', pad=8)
ax1.tick_params(axis='y', pad=8)
ax1.get_xaxis().get_major_formatter().set_useOffset(False)
ax2.tick_params(axis='y', pad=8)

plt.subplots_adjust(wspace=0.15)

plt.subplots_adjust(bottom=0.12)
plt.subplots_adjust(top=0.94)
plt.subplots_adjust(left=0.12)
plt.subplots_adjust(right=0.88)

plt.savefig('comparison_pk2stress_twinning_100compression_debug_modelni2cr.pdf', bbox_inches='tight', pad_inches=0.1)
plt.savefig('comparison_pk2stress_twinning_100compression_debug_modelni2cr.png', bbox_inches='tight', pad_inches=0.1)

# Close all of the open figures
plt.close()


###############################################################
## New plot of strength and applied shear stress on twin system

fig = plt.figure()
ax3 = fig.add_subplot(111)
mpl.rcParams.update({'font.size': 14})

ln0 = ax3.plot(data['effective_strain'], data['strength_twin_0'], 'darkgreen', label=r'$(111)[\bar{2}11]$ strength')
ln1 = ax3.plot(data['effective_strain'], data['strength_twin_1'], 'teal', label=r'$(111)[1\bar{2}1]$ strength')
ln2 = ax3.plot(data['effective_strain'], data['strength_twin_2'], 'sienna', label=r'$(111)[11\bar{2}]$ strength')

ln3 = ax3.plot(data['effective_strain'], data['strength_twin_3'], 'slateblue', label=r'$(\bar{1}11)[211]$ strength')
ln4 = ax3.plot(data['effective_strain'], data['strength_twin_4'], 'steelblue', label=r'$(\bar{1}11)[\bar{1}\bar{2}1]$ strength')
ln5 = ax3.plot(data['effective_strain'], data['strength_twin_5'], 'olive', label=r'$(\bar{1}11)[\bar{1}\bar{1}\bar{2}]$ strength')

ln6 = ax3.plot(data['effective_strain'], data['strength_twin_6'], 'mediumorchid', label=r'$(1\bar{1}1)[\bar{2}\bar{1}1]$ strength')
ln7 = ax3.plot(data['effective_strain'], data['strength_twin_7'], 'darkviolet', label=r'$(1\bar{1}1)[\bar{2}\bar{1}1]$ strength')
ln8 = ax3.plot(data['effective_strain'], data['strength_twin_8'], 'royalblue', label=r'$(1\bar{1}1)[1\bar{1}\bar{2}]$ strength')

ln9 = ax3.plot(data['effective_strain'], data['strength_twin_9'], 'indigo', label=r'$(\bar{1}\bar{1}1)[2\bar{1}\bar{1}]$ strength')
ln10 = ax3.plot(data['effective_strain'], data['strength_twin_10'], 'mediumvioletred', label=r'$(\bar{1}\bar{1}1)[\bar{1}21]$ strength')
ln11 = ax3.plot(data['effective_strain'], data['strength_twin_11'], 'crimson', label=r'$(\bar{1}\bar{1}1)[\bar{1}\bar{1}\bar{2}]$ strength')

ln12 = ax3.plot(data['effective_strain'], data['twin_tau_0'], 'darkgreen', marker='o', markevery=10, label=r'$(111)[\bar{2}11]$ strength')
ln13 = ax3.plot(data['effective_strain'], data['twin_tau_1'], 'teal', marker='o', markevery=10, label=r'$(111)[1\bar{2}1]$ strength')
ln14 = ax3.plot(data['effective_strain'], data['twin_tau_2'], 'sienna', marker='o', markevery=10, label=r'$(111)[11\bar{2}]$ strength')

ln15 = ax3.plot(data['effective_strain'], data['twin_tau_3'], 'slateblue', marker='o', markevery=10, label=r'$(\bar{1}11)[211]$ strength')
ln16 = ax3.plot(data['effective_strain'], data['twin_tau_4'], 'steelblue', marker='o', markevery=10, label=r'$(\bar{1}11)[\bar{1}\bar{2}1]$ strength')
ln17 = ax3.plot(data['effective_strain'], data['twin_tau_5'], 'olive', marker='o', markevery=10, label=r'$(\bar{1}11)[\bar{1}\bar{1}\bar{2}]$ strength')

ln18 = ax3.plot(data['effective_strain'], data['twin_tau_6'], 'mediumorchid', marker='o', markevery=10, label=r'$(1\bar{1}1)[\bar{2}\bar{1}1]$ strength')
ln19 = ax3.plot(data['effective_strain'], data['twin_tau_7'], 'darkviolet', marker='o', markevery=10, label=r'$(1\bar{1}1)[\bar{2}\bar{1}1]$ strength')
ln20 = ax3.plot(data['effective_strain'], data['twin_tau_8'], 'royalblue', marker='o', markevery=10, label=r'$(1\bar{1}1)[1\bar{1}\bar{2}]$ strength')

ln21 = ax3.plot(data['effective_strain'], data['twin_tau_9'], 'indigo', marker='o', markevery=10, label=r'$(\bar{1}\bar{1}1)[2\bar{1}\bar{1}]$ strength')
ln22 = ax3.plot(data['effective_strain'], data['twin_tau_10'], 'mediumvioletred', marker='o', markevery=10, label=r'$(\bar{1}\bar{1}1)[\bar{1}21]$ strength')
ln23 = ax3.plot(data['effective_strain'], data['twin_tau_11'], 'crimson', marker='o', markevery=10, label=r'$(\bar{1}\bar{1}1)[\bar{1}\bar{1}\bar{2}]$ strength')

ln24 = ax3.plot(data['effective_strain'], data['vonmises_stress_pk2'], 'salmon', marker='d', label=r'vonMises PK$_2$ stress')

ax3.set_xlabel('Effective Strain (mm/mm)', fontsize=16)
ax3.set_ylabel('Stress (MPa)', fontsize=16)
ax3.tick_params(labeltop=False, left=True, right=True, direction='in')
ax3.set_title(r'FCC Ni$_2$Cr, Loaded along $[100]$ in Compression')

ax3ins=inset_axes(ax3, width=1.7, height=1.0, loc='upper left', borderpad=1, bbox_to_anchor=(0.175, 0.95), bbox_transform=ax3.figure.transFigure)
ax3ins.plot(data['effective_strain'], data['strength_twin_11'], 'crimson', label=r'$(\bar{1}\bar{1}1)[\bar{1}\bar{1}\bar{2}]$ strength')
ax3ins.plot(data['effective_strain'], data['twin_tau_9'], 'indigo', marker='o', markevery=10, label=r'$(\bar{1}\bar{1}1)[2\bar{1}\bar{1}]$ strength')

ax3ins.set_xlim(0.00085, 0.00095)
ax3ins.set_ylim(85,95)
ax3ins.xaxis.set_ticks(np.arange(0.00085, 0.00095, 0.0001))
ax3ins.get_xaxis().get_major_formatter().set_useOffset(False)
ax3ins.tick_params(labelsize=10)
mark_inset(ax3, ax3ins, loc1=1, loc2=3, fc="none", ec="0.5")


lines = ln0 + ln1 + ln2 + ln3 + ln4 + ln5 + ln6 + ln7 + ln8 + ln9 + ln10 + ln11 + ln12 + ln13 + ln14 + ln15 + ln16 + ln17 + ln18 + ln19 +ln20 + ln21 + ln22 + ln23 + ln24
labels = [l.get_label() for l in lines]
ax3.legend(lines, labels, loc='upper center', fontsize=10, numpoints=1, ncol=2, bbox_to_anchor=(0.5, -0.2))

ax3.tick_params(axis='x', pad=8)
ax3.tick_params(axis='y', pad=8)
ax3.get_xaxis().get_major_formatter().set_useOffset(False)

plt.subplots_adjust(wspace=0.15)

plt.subplots_adjust(bottom=0.12)
plt.subplots_adjust(top=0.94)
plt.subplots_adjust(left=0.12)
plt.subplots_adjust(right=0.88)

plt.savefig('comparison_strength_appliedStress_100compression_debug_modelni2cr.pdf', bbox_inches='tight', pad_inches=0.1)
# plt.savefig('comparison_strength_appliedStress_100compression_debug_modelni2cr.png', bbox_inches='tight', pad_inches=0.1)
