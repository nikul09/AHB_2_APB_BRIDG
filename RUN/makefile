#
# Template for Makefile

################################################################################
PROJECT_NAME = ahb_2_apb_bridge_verification
################################################################################

INCL      = +incdir+../BRI +incdir+../MEM +incdir+../SQN +incdir+../ENV +incdir+../TEST


################################################################################

################################################################################

BASE_PKG      = ../TOP/ahb_pkg.sv


################################################################################

DEFINES   = 
COMP_OPTS =  -sverilog -l vcs.log  $(UVM) $(BASE_PKG) $(INCL) $(DEFINES)
RUN_OPTS  = -l simv.log
TEST = ahb_senity_test

# ToDo: Top level dut file

DUT = 

#Checking the VCS version

VCS_VERSION = $(shell vcs -id > vcs_version ; grep "Compiler version" vcs_version | awk -F " " '{print $$5}')

#This variable contains all the UVM-1.0 supported VCS tool versions.

UVM10_SUPP_VCS_VERSNS = E-2011.03 
SEED      = 1 # Default seed set to 1
VERBOSITY = debug
MODE      = NORMAL # Default configuration record-replay mode set to NORMAL
UVM_TEST  = ahb_senity_test

PKG = ../TOP/ahb_pkg.sv
TOP = ../TOP/top.sv
INCLUDE = +incdir+../BRI +incdir+../MEM +incdir+../SQN +incdir+../ENV +incdir+../TEST

#### VCS and UVM checking

ifdef VCS_HOME
 ifneq ($(VCS_VERSION),$(filter $(VCS_VERSION),$(UVM10_SUPP_VCS_VERSNS)))
  VCS_VERS_WARNING = 1
 endif  
 ifndef UVM_HOME
  UVM = -ntb_opts uvm 
 else
  UVM = -debug_acc+pp+dmptf +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS 
 endif
else
 ERR_STATUS = 1
endif

COMP_OPTS =  -sverilog -l vcs.log  $(UVM) $(BASE_PKG) $(INCL)  $(DEFINES)

all default: check clean comp run

check:
ifdef VCS_VERS_WARNING
	@echo ""
	@echo "VCS version is ${VCS_VERSION}"
	@echo "WARNING: VCS version should be atleast E-2011.03 or greater"
	@echo ""
endif
ifdef ERR_STATUS
	@echo ""
	@echo "ERROR : VCS_HOME is not set"
	@echo "Please set VCS_HOME to run this Makefile"
	@echo ""
endif

comp: check
ifndef ERR_STATUS
ifeq ($(MODE), RECORD)
		vcs $(COMP_OPTS)  \
        	 -debug_all  ../TOP/top.sv 
else		 
ifeq ($(MODE), DEBUG)
		vcs $(COMP_OPTS)  \
        	 -debug_all  ../TOP/top.sv
else			 
		vcs $(COMP_OPTS)  \
        	 ../TOP/top.sv \
			 '+define+SVT_FSDB_ENABLE +define+WAVES_FSDB +define+WAVES=\"fsdb\"' \
			 -P ${VERDI_HOME}/share/PLI/VCS/LINUX/novas.tab ${VERDI_HOME}/share/PLI/VCS/LINUX/pli.a
endif			 
endif		 
endif

run: check
ifndef ERR_STATUS
ifeq ($(MODE), RECORD)
	./simv  $(RUN_OPTS) \
        +ntb_random_seed=$(SEED) +UVM_TESTNAME=$(UVM_TEST) +UVM_TR_RECORD +UVM_LOG_RECORD
else	
	./simv  $(RUN_OPTS) \
        +ntb_random_seed=$(SEED) +UVM_TESTNAME=$(UVM_TEST)
endif	
endif

vcscomp:
	vcs -l ./log/compile.log -q -Mdir=.output/csrc $(PKG) $(TOP) $(INCLUDE) -CFLAGS -DVCS ${vcs_incdir_options} ${vcs_waves_defines} ${vcs_pa_defines} ${vcs_waves_options}
	${vcs_pa_options} ${vcs_lca_option} -full64 -sverilog +define+UVM_PACKER_MAX_BYTES=1500000 +define+UVM_DISABLE_AUTO_ITEM_RECORDING -timescale=1ns/1ps 
	+define+SVT_UVM_TECHNOLOGY +define+SYNOPSYS_SV +define+SVT_UVM_TECHNOLOGY +define+SYNOPSYS_SV ${vcslibs} -o ./output/simvcssvlog
	./output/simvcssvlog +UVM_TESTNAME=${TEST} +UVM_VERBOSITY=$(VERBOSITY) ${vcs_trace} -l ./logs/simulate_${TEST}.log run

clean:
	rm -rf simv* csrc
	rm -rf vc_hdrs.h .vcsmx_rebuild *.log
	rm -rf work/* *.svshell vcs_version

help:
	@echo "****************************************************************"
	@echo "***   Makefile Help for AHB_2_APB BEIDGE VERIFICATION :      ***"
	@echo "****************************************************************"
	@echo "*  Usage:                                                      *"
	@echo "*  ------                                                      *"
	@echo "*  make       Compile and Run the testcase                     *"
	@echo "*                                                              *"
	@echo "*  Available targets:                                          *"
	@echo "*  make help  [To see the Help]                                *"
	@echo "*  make clean [Remove simulation generated files/directories]  *"
	@echo "*  make comp  [Compile the testcase]                           *"
	@echo "*  UVM_TEST   [To pass the name of the UVM test]               *"
#	@echo "*                                                              *"
	@echo "*  Optional Arguments                                          *"
#	@echo "*  VERBOSITY         [Message severity to be display]          *"
#	@echo "*  make VERBOSITY=<sev> [example make VERBOSITY=note]          *"
	@echo "*  MODE = RECORD/DEBUG                                         *"
	@echo "*  make MODE=RECORD  [To enable UVM TR Record mechanism]       *"
	@echo "*  make MODE=DEBUG  [To enable -debug_all]                     *"
	@echo "****************************************************************"

