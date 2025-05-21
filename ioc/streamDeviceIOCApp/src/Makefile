TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = streamDeviceIOC
streamDeviceIOC_LIBS += stream
streamDeviceIOC_LIBS += asyn
streamDeviceIOC_LIBS += calc
streamDeviceIOC_LIBS += caPutLog
streamDeviceIOC_LIBS += autosave

# streamDeviceIOC.dbd will be created and installed
DBD += streamDeviceIOC.dbd

# streamDeviceIOC.dbd will be made up from these files:
streamDeviceIOC_DBD += base.dbd

streamDeviceIOC_DBD += caPutLog.dbd
streamDeviceIOC_DBD += calcSupport.dbd
streamDeviceIOC_DBD += asyn.dbd
streamDeviceIOC_DBD += stream.dbd
streamDeviceIOC_DBD += asSupport.dbd
streamDeviceIOC_DBD += drvAsynIPPort.dbd
streamDeviceIOC_DBD += drvAsynSerialPort.dbd

# Include dbd files from all support applications:
#streamDeviceIOC_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#streamDeviceIOC_LIBS += xxx

# streamDeviceIOC_registerRecordDeviceDriver.cpp derives from streamDeviceIOC.dbd
streamDeviceIOC_SRCS += streamDeviceIOC_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
streamDeviceIOC_SRCS_DEFAULT += streamDeviceIOCMain.cpp
streamDeviceIOC_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#streamDeviceIOC_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
streamDeviceIOC_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

