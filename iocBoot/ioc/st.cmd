#!/ioc/bin/linux-x86_64/ioc

epicsEnvSet("TOP", "/ioc")
epicsEnvSet("ENGINEER", "Abdalla")
epicsEnvSet("LOCATION", "Machine")
epicsEnvSet("IOC_PREFIX","IOC-PSS")

dbLoadDatabase "dbd/ioc.dbd"
ioc_registerRecordDeviceDriver pdbbase

dbLoadRecords "db/pss.db" "PLC=Booster_PSS_PLC"
dbLoadRecords "db/pss-interlocks.db"
#dbLoadRecords "db/pss-ms-status.db"
#dbLoadRecords "db/pss-ms-oh-emergency.db"
dbLoadRecords "db/pss-ms-shutters.db"
dbLoadRecords "db/pss-ms-emergency.db"
dbLoadRecords "db/pss-beats-shutters.db"
dbLoadRecords "db/pss-beats-emergency.db"
dbLoadRecords "db/pss-heseb-shutters.db"
dbLoadRecords "db/pss-xafs-shutters.db"
dbLoadRecords "db/pss-xafs-emergency.db"
dbLoadRecords "db/pss-bl-intrusion.db"
dbLoadRecords "db/radiation-monitors.db"
dbLoadRecords("$(TOP)/db/iocAdminSoft.db", "IOC=$(IOC_PREFIX)")

EIP_buffer_limit(450)
drvEtherIP_init()
drvEtherIP_define_PLC("Booster_PSS_PLC","bo-pss-plc",0)
drvEtherIP_define_PLC("MS_PSS_PLC","10.2.5.70",0)
drvEtherIP_define_PLC("BEATS_PSS_PLC","10.2.5.90",0)
drvEtherIP_define_PLC("XAFS_PSS_PLC","10.2.5.30",0)

# asSetFilename("$(TOP)/common.acf")

iocInit

