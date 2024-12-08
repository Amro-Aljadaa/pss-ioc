TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this
DB += pss.db
DB += pss-interlocks.db
DB += pss-ms-status.db
DB += pss-ms-oh-emergency.db
DB += pss-ms-shutters.db
DB += pss-beats-shutters.db
DB_INSTALLS += $(DEVIOCSTATS)/db/iocAdminSoft.db
include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

