# nasuni-analyticsconnector-manager
Terraform script for provisioning the Nasuni Analytics Connector Manager
Mandatory KVPs to be passed via tfvars file are:
	1- region		:	Amazon region
	2- aws_profile		:	AWS user profile
	2- pem_key_file		: 	Pem Key file path to be used to SSH the NACScheduler instance
	4- aws_key		:	Key Pair Name used to provision the NAC Scheduler instance
	5- nac_scheduler_name 	: 	NAC Scheduler name to be passed by User(default is NACScheduler)