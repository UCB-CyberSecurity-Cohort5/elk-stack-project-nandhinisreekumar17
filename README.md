# Contents of Repository

- **Ansible**: Filebeat and Metricbeat configuration, Ansible configuration, hosts files, playbook files for installing ELK, Filebeat, Metricbeat and configuring the VM with Docker
- **Diagrams:** Network Diagrams from Networking and Cloud Security
- **Images:** Images used in the README
- **Linux:** Shell scripts
- **README.md:** Automated ELK Stack Deployment

---

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Red Team Network Diagram](Images/Red_Team_Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the following playbook files may be used to install only certain pieces of it, such as Filebeat.

* [my-playbook.yml](Ansible/my-playbook.yml) – playbook used to install D*mn Vulnerable Web App (DVWA) servers
* [install-elk.yml](Ansible/install-elk.yml) – playbook used to install ELK Server
* [filebeat-playbook.yml](Ansible/filebeat-playbook.yml) – playbook used to install and configure Filebeat on ELK Server and DVWA servers
* [metricbeat-playbook.yml](Ansible/metricbeat-playbook.yml) – playbook used to install and configure Metricbeat on ELK Server and DVWA servers

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network. A load balancer is placed in front of all machines in the virtual network, RedTeamNet.

What aspect of security do load balancers protect?

- A load balancer is used to distribute network traffic across several resources to prevent the overloading of a particular resource. From a security point of view, load balancers deploy network-based IDS/IPS systems and has the potential of preventing DDoS attacks by shifting the traffic directed towards an organizational network to a different network.

What is the advantage of a jump box?

- The jump box is placed in front of the other machines preventing their exposure to the public. These machines can be connected to using dynamic IP. We can restrict the IP addresses that can communicate with the jump box by creating inbound security rules in the network security groups.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the file systems and system metrics.

What does Filebeat watch for?

- Filebeat monitors the log files or locations that is specified. It collects log events, and forwards them to Elasticsearch. It watches for file changes.

What does Metricbeat record?

 - Metricbeat records metrics from the operating system and services running on the server periodically.

The configuration details of each machine may be found below.

| Name                 	| Function   	|  IP Address 	| Operating System 	|
|----------------------	|------------	|-------------	|------------------	|
| Jump-Box-Provisioner 	| Gateway    	| 10.0.0.4    	| Linux            	|
| Web-1                	| Web Server 	| 10.0.0.5    	| Linux            	|
| Web-2                	| Web Server 	| 10.0.0.6    	| Linux            	|
| Web-3                	| Web Server 	| 10.0.0.7    	| Linux            	|
| ELKServer            	| Monitoring  	| 10.1.0.4    	| Linux            	|

The webservers belong to an availability set.

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump box machine (Jump-Box-Provisioner) can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- Personal Public IP address

Machines within the network can only be accessed by using SSH from the jump box machine.

ELK VM can be accessed by SSH from the Jump box machine and from my personal machine using web access (TCP). 
Jump Box IP Address:  10.0.0.4 and Personal Public IP address.

A summary of the access policies in place can be found in the table below.

| Name                 	| Publicly Accessible 	| Allowed IP Addresses                                                            	|
|----------------------	|---------------------	|---------------------------------------------------------------------------------	|
| Jump-Box-Provisioner 	| Yes                 	| Personal Public IP Address                                                      	|
| Web-1                	| No                  	| 10.0.0.4 (Jumpbox Pvt IP) on port 22                                            	|
| Web-2                	| No                  	| 10.0.0.4 (Jumpbox Pvt IP) on port 22                                            	|
| Web-3                	| No                  	| 10.0.0.4 (Jumpbox Pvt IP) on port 22                                            	|
| ELKServer            	| Yes                 	| Personal Public IP Address on port 5601<br>10.0.0.4 (Jumpbox Pvt IP) on port 22 	|

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because there is minimal amount of error when automating the configurations.

What is the main advantage of automating configuration with Ansible?

- The main advantage of configuring with Ansible is that multiple servers can be easily configured, and programs and configurations can be updated on these servers at the same time irrespective of the number of servers.

The playbook implements the following tasks:

* 	Install docker.io
*	Install python3-pip
*	Install docker module
*	Increase virtual memory
*	Download and launch a docker elk container
*	Enable docker service on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker PS Output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

*	Web-1 | 10.0.0.5
*	Web-2 | 10.0.0.6
*	Web-3 | 10.0.0.7

We have installed the following Beats on these machines:

*	[Filebeat](Ansible/filebeat-playbook.yml)
*	[Metricbeat](Ansible/metricbeat-playbook.yml)

These Beats allow us to collect the following information from each machine:

- Filebeat collects details about the file system like logs, changes to the files and remote access.

- Metricbeat collects system metrics like uptime, CPU usage and available memory.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
*	Copy the [filebeat-config.yml](Ansible/filebeat-config.yml) and [metribeat-config.yml](Ansible/metricbeat-config.yml) files to [/etc/ansible/files](Ansible/ansible.cfg).
*	Update the [/etc/ansible/hosts](Ansible/hosts) file to include the machines on which the ELK server and Filebeat should be installed. 

```
[webservers]
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
10.0.0.7 ansible_python_interpreter=/usr/bin/python3

[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3
```
*	Run the playbook and navigate to http://[ELK_Server_Public_IP]:5601 to check that the installation worked as expected.

With the help of Wireshark and Kibana, we can monitor the VMs to detect any suspicious authentication attempts.

<details><summary><b> Click here for the report of the investigation completed using Kibana. </b> </summary>
<br> 
1.	In the last 7 days, how many unique visitors were located in India?

```Answer : 223```

![Unique visitors located in India](Images/India_unique.png)
	
2.	In the last 24 hours of the visitors from China, how many were using Mac OSX?
	
```Answer : 13```
	
![Visitors from China using Mac OSX](Images/China_macox.png)
	
3.	In the last 2 days, what percentage of visitors received 404 errors? How about 503 errors?

```Answer : 404 – 0% ; 503 – 0%```
	
![Percentage of visitors who received 404 errors and 503 errors](Images/404_503_errors.png)
 
4.	In the last 7 days, what country produced the majority of the traffic on the website?

```Answer : China```
	
![Country that produced the majority of the traffic on the website](Images/Majority_traffic.png)
 

5.	Of the traffic that's coming from that country, what time of day had the highest amount of activity?

```Answer : 10 am and 12 pm```
	
![Time of the day that had the highest amount of activity](Images/Highest_amount_of_traffic_10.png)

![Time of the day that had the highest amount of activity](Images/Highest_amount_of_traffic_12.png)

6.	List all the types of downloaded files that have been identified for the last 7 days, along with a short description of each file type.

- **gz:** .gz files are archived files compressed by the standard GNU zip (gzip) compression algorithm. It stands for Gnu Zipped Archive.
- **css:** .css files are used to format the contents of a webpage like indentation, font, size, color, line spacing, border and location of HTML information on a webpage. It stands for Cascading Style Sheet. 
- **zip:** .zip files are archive file that contains one or more compressed files or directories. It supports lossless data compression. It stands for zipped file.
- **deb:** A .deb file is a Debian Software Package file used by Debian Linux Distribution and its variants. Each DEB file is a standard Unix archive that contains two .tar archives: one for installer control information and another for installable data.
- **rpm:** .rpm file is an installation package originally developed for the Red Hat Linux operating system. It stands for Red Hat Package Manager File.

![Types of downloaded files that have been identified for the last 7 days](Images/Downloaded_files.png)

From Unique Visitors Vs. Average Bytes chart,

7.	Locate the time frame in the last 7 days with the most amount of bytes (activity).

```Answer: 6 pm on 20th March 2022```

![Time frame in the last 7 days with the most amount of bytes](Images/Time_frame_most_amount_of_bytes.png) 

8.	In your own words, is there anything that seems potentially strange about this activity?

```Answer: It is strange that a single visitor is using a much higher number of bytes (15709) than other visitors.```
	
On filtering the data by this event, 

9.	What is the timestamp for this event?

```Answer: The time stamp is 19:55 for the filter Mar 20, 2022 @ 18:00:0 Mar 20, 2022 @ 21:00:0.```

![Time stamp of the event with the most amount of bytes](Images/Time_stamp_most_amount_of_bytes.png)

10.	What kind of file was downloaded?

```Answer:  An rpm file```

![Kind of file that was downloaded](Images/Kind_of_file_most_amount_of_bytes.png)

11.	From what country did this activity originate?

```Answer: India```
	
![Country from where the activity originated](Images/Country_originated_most_amount_of_bytes.png)

12.	What HTTP response codes were encountered by this visitor?

```Answer: 200```

![HTTP response codes encountered by the visitor](Images/HTTP_response_codes_most_amount_of_bytes.png)

Switch over to the Kibana Discover page,

13.	What is the source IP address of this activity?

```Answer: 35.143.166.159```

14.	What are the geo coordinates of this activity?

```Answer: { "lat": 43.34121, "lon": -73.6103075 }```
 
![Source IP address and geo coordinates of the activity](Images/Source_IP_most_amount_of_bytes.png)

15.	What OS was the source machine running?

```Answer: Windows 8```

![OS of the source machine](Images/OS_source_url_machine_most_amount_of_bytes.png) 

16.	What is the full URL that was accessed?

```Answer: https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-6.3.2-i686.rpm```

![URL that was accessed](Images/URL_most_amount_of_bytes.png)  

17.	From what website did the visitor's traffic originate?

```Answer: Facebook```

![Website from where the visitor's traffic originated](Images/Website_originated_most_amount_of_bytes.png)  

18.	What do you think the user was doing?

```Answer:  I think the user was trying to download an installation package (Metricbeat) for Linux from the website.```

19.	Was the file they downloaded malicious? If not, what is the file used for?

```Answer: The installation does not seem malicious but could be. The file is usually used to download or update Metricbeat.```

20.	Is there anything that seems suspicious about this activity?

```Answer: Yes, the referrer for the download website was Facebook.```

21.	Is any of the traffic you inspected potentially outside of compliance guidelines?

```Answer: Since the download link was posted on Facebook, it might be outside of compliance guidelines. Ideally speaking, it is not expected to have a download/update link posted to social media.```

In order to verify the ELK Server is functioning properly and Filebeat and Metricbeat are collecting data correctly, the following tasks are performed:

1.	Generate a high amount of failed SSH login attempts and verify that Kibana is picking up this activity.
2.	Generate a high amount of CPU usage on the pen-testing machines and verify that Kibana picks up this data.
3.	Generate a high amount of web requests to your pen-testing servers and make sure that Kibana is picking them up.

#### Generate a high amount of failed SSH login attempts

1.	Instead of accessing the Web-1 through the Ansible container, we connect from the Jumpbox. This would record the failed login attempts because the Ansible container contains our SSH keys.

	```ssh RedAdmin@10.0.0.5```

2.	Ran the above command in a loop to generate failed login log entries.

	```for i in {1..10}; do ssh RedAdmin@10.0.0.5; done```

**Syntax breakdown:**
	
- `for` begins the `for` loop.
- `i` creates a variable named `i` that will hold each number in our list.
- `{1..10}` creates a list of 10 numbers, each of which will be given to our `i` variable.
- `;` separates the portions of `for` loop when written on one line.
- `do` indicates the action taken by each loop.
- `ssh RedAdmin@10.0.0.5` is the command `do` runs.
- `;` separates the portions of `for` loop when written on one line.
- `done` closes the `for`- loop.

![Loop to generate failed login log entries](Images/Loop_to_generate_failed_login_log_entries.png)

3.	Checked Kibana logs if the login attempts were recorded.

![Kibana failed login log entries](Images/Kibana_failed_login_log_entries.png) 

**Bonus:** Created a nested loop that generates SSH login attempts across all webservers.

```while true; do for i in {5..7}; do ssh RedAdmin@10.0.0.$i; done; done```

**Syntax Breakdown:**

- `i` creates a variable named `i` that will hold each number in our list.
- `{5..7}` creates a list of numbers (5, 6 and 7), each of which will be given to `i` variable to represent the IP addresses of the webservers.
- `;` separates the portions of `for` loop when it is written on one line.
- `do` indicates the action taken each loop.
- `ssh RedAdmin@10.0.0.$i` is the command `do` runs . It is passing in the `$i` variable so the ssh command will be run on each webserver.
- `;` separates the portions of `for` loop when it is written on one line.
- `done` closes the for loop.

![Loop to generate failed login log entries to all webservers](Images/Loop_to_generate_failed_login_log_entries_to_all_VMs.png) 

#### Generate a high amount of CPU usage on the pen-testing machines

1.	Started and attached to the Ansible container from the Jumpbox

	``sudo docker start competent_lumiere```
	``sudo docker attach competent_lumiere```

 ![Start and attach the Ansible container](Images/Started_and_attached_to_the_Ansible_container.png)

2.	Connected by SSH from the Ansible container to Web-1.

	```ssh RedAdmin@10.0.0.5```
	
 ![SSH connection from Ansible container to Web-1](Images/SSH_from_Ansible_container_to_web_1.png) 

3.	Intstalled the stress program.

	```sudo apt install stress```
	
 ![Install stress](Images/Install_stress.png) 

4.	Let stress run for a few minutes.

	```sudo stress --cpu 1```
	
  ![Run stress](Images/Run_stress.png) 

5.	Checked Kibana for the change in the system metrics.

 ![Check Kibana for change in metrics](Images/Kibana_check_change_metrics.png)  

6.	Ran the stress program on all three of the VMs and checked the Metric page on Kibana.

 ![Run stress program on Web-1 Inventory](Images/Stress_program_on_web_1_inventory.png)
	
 ![Run stress program on Web-1 CPU Usage](Images/Stress_program_on_web_1_CPU_usage.png)
	
 ![Run stress program on Web-2 Inventory](Images/Stress_program_on_web_2_inventory.png)
	
 ![Run stress program on Web-2 CPU Usage](Images/Stress_program_on_web_2_CPU_usage.png)
	
 ![Run stress program on Web-3 Inventory](Images/Stress_program_on_web_3_inventory.png)
	
 ![Run stress program on Web-3 CPU Usage](Images/Stress_program_on_web_3_CPU_usage.png)
	

#### Generate a high amount of web requests to your pen-testing servers

1.	Logged into the Jumpbox.

	```ssh RedAdmin@13.83.47.196```

2.	Ran wget command to download index.html file.

	```wget 10.0.0.5```

3.	Listed the contents to view the fie downloaded.

	```ls```

4.	Ran a loop to generate a lot of web requests using wget.

	```for i in {1..10}; do wget 10.0.0.5; done```
	
**Syntax breakdown:**
	
- `for` begins the `for` loop.
- `i` in creates a variable named `i` that will hold each number in our list.
- `{1..10}` creates a list of 10 numbers, each of which will be given to our `i` variable.
- `;` separates the portions of `for` loop when written on one line.
- `do` indicates the action taken by each loop.
- `wget 10.0.0.5` is the command `do` runs.
- `;` separates the portions of `for` loop when written on one line.
- `done` closes the `for` loop

 ![Loop to generate a lot of web requests using wget](Images/Generate_lot_of_web_requests_using_wget.png)

On checking the Metrics page for Web-1 on Kibana, the following was noted:

![Kibana metrics for wget for Web 1](Images/Kibana_web_requests_using_wget_1.png)

![Kibana metrics for wget for Web 1](Images/Kibana_web_requests_using_wget_2.png)

**Bonus:** Since `wget` creates a lot of duplicate files, we use `rm` command to delete all files. We use the following command not to save any files.

```while true; do wget 10.0.0.5 -O /dev/null; done```

![Remove duplicate files](Images/Command_not_to_save_files.png)
 
**Bonus:** Write a nested loop that sends your wget command to all VMs over and over.
	
```while true; do for i in {5..7}; do wget -O /dev/null 10.0.0.$i; done; done```

**Syntax Breakdown:**
	
- `i` in creates a variable named `i` that will hold each number in our list.
- `{5..7}` creates a list of numbers (5, 6 and 7), each of which will be given to `i` variable to represent the IP addresses of the webservers.
- `;` separates the portions of `for` loop when it is written on one line.
- `do` indicates the action taken each loop.
- `wget 10.0.0.$i` is the command `do` runs . It is passing in the `$i` variable so the ssh command will be run on each webserver.
- `done` closes the `for` loop.
	
![Send wget command to all webservers](Images/Loop_that_sends_your_wget_command_to_all_VMs.png)

 </details>
 
---

<details><summary> <b> Click here for the usage instructions for Automated ELK Stack Deployment </b> </summary>
	
### Usage Instructions for Automated ELK Stack Deployment

#### Pre-requisites

- Azure Portal account
- Resource Group: RedTeam
- Virtual Network: RedTeamNet (10.0.0.0/16; Subnet – 10.0.0.0/24)
- Network Security Group: RedTeamSecurityGroup

	Rules:
	- Port 80 from workstation IP to VNet
	- Port 22 from 10.0.0.4 (Jump Box Provisioner) to VNet
	- Port 22 from workstation IP to 10.0.0.4 (Jump Box Provisioner)
	- Allow Vnet Inbound
	- Allow Azure Load Balancer Inbound
	- Deny All Inbound

- Jumpbox: Jump-Box-Provisioner with Ansible (Public IP: 13.83.47.196 Private IP: 10.0.0.4)
- Web Servers: Web-1 (Private IP: 10.0.0.5), Web-2 (Private IP: 10.0.0.6) and Web-3 (Private IP: 10.0.0.7)
- Load Balancer: RedTeamLoadBalancer (Front End IP: 13.64.143.159)

The diagram below shows the network diagram representing the pre-requisites.

 ![Red Team Network Diagram](Images/Red_Team_Network_Diagram.png)

### Instructions:

**Chapter 1: Create a new Virtual Network**

1.	On the Azure portal, create a new virtual network located in the same resource group where the pre-requisite VMs (web servers) are located and in a new region that is different from that of the other VMs. 

	- In my example, I had created RedTeamNet in US West zone and created ELKNet in US East zone.

 	![Create virtual network - Basics](Images/Create_virtual_network_basics.png)

	- Click Next. 
          The IP addresses space will be automatically created. 
          Select the default subnet.

 	![Create virtual network - IP Address](Images/Create_virtual_network_IP_address.png)

	- Click Next. 
          Leave the settings at default.

 	![Create virtual network - Security](Images/Create_virtual_network_security.png)

	- Click Next. 
          Leave the settings at default.

	![Create virtual network - Tags](Images/Create_virtual_network_tags.png)
 

	- Click Next. 
          Review the settings and click on Create.

 	![Create virtual network - Review and create](Images/Create_virtual_network_review_create.png)
	![Create virtual network - Deployment Completed](Images/Create_virtual_network_deployment_complete.png)

2.	Create a peer connection between your virtual networks.

	- Navigate to 'Virtual Network' in the Azure Portal.
          Select your new virtual network.

 	![Create peer network - Main Screen](Images/Create_peer_connection_main.png)
	![Create peer network - ELK Settings](Images/Create_peer_connection_elk_settings.png)
 
 	- Under ‘Settings’ on the left side, select ‘Peerings’.
       	  Click on ‘Add’ to create a new peering.
	
 	![Create peer network - Add New](Images/Create_peer_connection_add_new.png)

	- Add peering link names for the ELK virtual network and remote virtual network (RedTeamNet).
          Select remote virtual network (RedTeamNet) from the ‘Virtual Network’ dropdown.
          Leave the remaining settings as default.

	![Create peer network - Add Peerings Names](Images/Create_peer_connection_add_peering_names.png)
	![Create peer network - Virtual Network](Images/Create_peer_connection_virtual_network.png)


	- Click Next

	![Create peer network - Peering Created](Images/Peer_connection_created.png)
 
**Chapter 2: Create a new Virtual Machine**

1.	Create a new Ubuntu VM (ELKServer)in the virtual network with the following configurations:

	a.	RAM:  4 GB+

	You can use either of these machines:
	- Standard D2s v3 (2 vcpus, 8GiB memory)
	- Standard B2s (2vcpus, 4GiB memory

	In case you are unable to get the required VM, try deploying the VM in a different region.

	b.	Operating System:  Ubuntu Server 18.04 LTS – Gen2 (free services eligible)

	To get the SSH key created on the Ansible container running on your jump box, follow the steps below:

	 1. SSH into the jump box through the terminal on your workstation.
	 2. Run the docker commands to start and attach to your Ansible container.

		```
		sudo docker start (container_name)
		sudo docker attach (container_name)
		```
	3. Retrieve your public ssh key.
		```cat ~/.ssh/id_rsa.pub```
	
	![Create virtual network - Basics 1](Images/Create_VM_Basics_1.png)
	![Create virtual network - Basics 2](Images/Create_VM_Basics_2.png)
	![Create virtual network - Basics 3](Images/Create_VM_Basics_3.png) 

	Click Next.

	c.	Disks: Standard SSD for OS Disk Type. Leave the remaining settings as default.
 
	![Create virtual network - Disks 1](Images/Create_VM_Disks_1.png)
	![Create virtual network - Disks 2](Images/Create_VM_Disks_2.png)
	 
	Click Next.
	
	d.	IP Address:   Create a new static public IP Address.
	
	![Create virtual network - IP Address](Images/Create_VM_IP_addressing.png)

	Click Next.
	
	e.	Networking: The VM should be added to the new region where you have created the virtual network. A new basic Security Group to be created for this VM.

	![Create virtual network - Networking 1](Images/Create_VM_networking_1.png)
	![Create virtual network - Networking 2](Images/Create_VM_networking_2.png)

	Click Next.

	f.	Management: Leave the settings as default.

 	![Create virtual network - Management 1](Images/Create_VM_Management_1.png)
	![Create virtual network - Management 2](Images/Create_VM_Management_2.png)
 
	Click Next.

	g.	Advanced: Leave the settings as default.

 	![Create virtual network - Advanced 1](Images/Create_VM_advanced_1.png)
	![Create virtual network - Advanced 2](Images/Create_VM_advanced_2.png)
	![Create virtual network - Advanced 3](Images/Create_VM_advanced_3.png)

	Click Next.

	h.	Tags: Leave the settings as default.
 
	![Create virtual network - Tags](Images/Create_VM_tags.png)

	Click Review + create.

	![Create virtual network - Review and Create](Images/Create_VM_review_create.png)
 
	Click Create.

	![Create virtual network - Deployment Complete](Images/Create_VM_deployment_complete.png)
 
	Click Go to resource to view the ELKServer VM.
	
	![Create virtual network - ELKServer VM](Images/Create_VM_elk_server_created.png)
	
2.	To verify if the VM was created correctly, SSH into the VM using the private IP address  from the Ansible container on jump box.
	
	![SSH to ELKServer VM](Images/SSH_into_ELK_server.png)
 

**Chapter 3: Downloading and Configuring the Container**

Using Ansible, we can configure the new VM to function as an ELK Server.

1.	From the Ansible VM, change to /etc/ansible/ directory.

	```cd /etc/ansible/```

2.	Add the new VM to Ansible’s hosts file for Ansible to understand the list of machines it can discover and connect to.

	```nano hosts```

3.	Add [elk] group and IP address of the ELKServer VM.
	We can specify the groups on which the playbooks should be run.

 	![Hosts file](Images/Hosts_file.png)

4.	Create the playbook to configure the ELK Server. The playbook should run on the [elk] group.

	The playbook should:
	- Install docker.io (Docker engine) and python3-pip (Python software installer) packages.
	- Install docker, the Python client for Docker which required by Ansible to control the state of Docker containers.
	- Download the Docker container called sebp/elk:761.
	- Configure the container to start with the following port mappings: 
		- 5601:5601
		- 9200:9200
		- 5044:5044
	- Start the container
	- Enables the docker service on boot

	```nano install-elk.yml```
	
	![Install ELK Server Playbook 1](Images/Install_elk_1.png)
	![Install ELK Server Playbook 2](Images/Install_elk_2.png)
	 

**Chapter 4: Launching and Exposing the Container**

1.	Run the playbook

	```ansible-playbook -m install-elk.yml```
	
 	![Run Install ELK Playbook](Images/Run_install_elk.png)

2.	SSH into the ELK Server VM and ensure sebp/elk:761 container is running.

	```docker ps```

 	![Docker PS Output](Images/docker_ps_output.png)
	
 
**Chapter 5: Identity and Access Management**

1.	On the Azure portal, navigate to network security groups.

 	![Network Security Groups](Images/IAM_network_security_groups.png)

2.	Create an inbound security rule in the network security group to allow traffic over TCP 5601 from the workstation public IP to the ELK Server and to restrict other access to the ELK Server.

 	![Inbound Security Rule 1](Images/IAM_NSG_security_rule_1.png)
	![Inbound Security Rule 2](Images/IAM_NSG_security_rule_2.png)

3.	Click Add.

 	![Inbound Security Rule Added](Images/IAM_NSG_security_rule_added.png)

4.	Navigate to http://[ELK-VM.External.IP]:5601/app/kibana to verify access to ELK Server.

 	![Verify Access to ELK Server](Images/'Kibana server landing page'.png)


**Chapter 6: Installing Filebeat on the DVWA Container**

1.	Click 'Explore on my Own' on the Kibana server landing page.

 	![Kibana Server Landing Page](Images/Kibana server landing page.png)

2.	Click Add Log Data.

 

3.	Choose System Logs.
Click on the DEB tab under Getting Started.

 

The Filebeat installation instructions can be found here which is used for installing Filebeat using ansible playbook.

4.	Install Filebeat using the commands displayed on the Kibana server landing page.

 

5.	Install Elasticsearch using the following commands:

curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-amd64.deb
sudo dpkg -i elasticsearch-7.6.2-amd64.deb
sudo /etc/init.d/elasticsearch start

 

6.	SSH into your Jumpbox.
7.	Start and attach to the docker container.
8.	Run the following curl command to get the filebeat configuration file:

curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat

 

We can also use the Filebeat configuration file template provided.

9.	Copy the content to a new file (filebeat-config.yml)

 

9.1 Edit the username and password to elastic and changeme respectively in the configuration file. Also, replace the IP address with the IP address of your ELK Server VM.

 

9.2 Scroll to line #1806 (setup.kibana) and replace the IP address with the IP address of your ELK machine.

 

 
Chapter 7: Creating the Filebeat Installation Play

1.	Create a playbook to install Filebeat in /etc/ansible/roles/ directory. (filebeat-playbook.yml) with the following tasks:

•	Download the .deb file from artifacts.elastic.co.
•	Install the .deb file.
•	Copy the Filebeat configuration file from the Ansible container to the WebVM(s) Filebeat was installed. 
•	Enable and configure the system modules
•	Setup Filebeat
•	Start Filebeat service
•	Enable the Filebeat service on boot.

 


 

 

2.	Save the file.
3.	Run the playbook.

 

 

 
Chapter 8: Verifying Installation and Playbook

1.	Navigate to the Filebeat installation page on Kibana.
2.	On the same page, scroll to Step 5: Module Status and click Check Data.
3.	Scroll to the bottom of the page and click Verify Incoming Data.

 
 
Chapter 9: Creating a Play to Install Metricbeat

1.	Click 'Explore on my Own' on the Kibana server landing page.

 

2.	Click Add Metric Data.

 


3.	Click Docker Metrics.
Click the DEB tab under Getting Started.

 

The Metricbeat installation instructions can be found here which is used for installing Metricbeat using ansible playbook.

4.	Install Metricbeat using the commands displayed on the Kibana server landing page.

 

5.	SSH into your Jumpbox.
6.	Start and attach to the docker container.
7.	Copy the content of the Metricbeat configuration file template to a new file (metricbeat-config.yml)

 
7.1 Edit the username and password to elastic and changeme respectively in the configuration file. Also, replace the IP address with the IP address of your ELK Server VM.

 

7.2 Scroll to line #1806 (setup.kibana) and replace the IP address with the IP address of your ELK machine.


 

8.	Create a playbook to install Filebeat in /etc/ansible/roles/ directory. (filebeat-playbook.yml) with the following tasks:

•	Download the .deb file from artifacts.elastic.co.
•	Install the .deb file.
•	Copy the Metribeat configuration file from the Ansible container to the WebVM(s) Metricbeat was installed. 
•	Enable and configure the docker module for metricbeat
•	Setup Metricbeat
•	Start Metricbeat service
•	Enable the Metricbeat service on boot

 


 

 

9.	Save the file.
10.	Run the playbook.

 
 

11.	Navigate to the Filebeat installation page on Kibana.
12.	On the same page, scroll to Step 5: Module Status and click Check Data.
13.	Scroll to the bottom of the page and click Verify Incoming Data.

 


	
</details>

---

<details><summary> <b> Click here for answers to potential interview questions based on the Automated ELK Server </b> </summary>

---

### Interview Questions and Answers

Question 1: Faulty Firewall

Suppose you have a firewall that's supposed to block SSH connections, but instead lets them through. How would you debug it?

1. Restate the problem

In order to restrict access to the VMs in your network, we need to deploy firewalls. Firewalls provide protection against outside cyberattacks by shielding the network from malicious traffic. A set of rules must be created to allow or deny traffic and access in the network. In case of an event where the firewall in place allows SSH connections when it is not supposed to, it can cause severe consequences like unauthorized access leading to breach of secure data.

2. Provide a Concrete Example Scenario

During the project on automated ELK server deployment which we had done during the cybersecurity bootcamp, we had set up a network with 4 VMs connected to another VM which was configured as a jump box. Only the jump box VM could be accessed from the Internet using SSH. The other VMs are accessed through the jump box using SSH. If we try to access a VM that does not accept SSH connections, our access will be denied since the security rules do not permit the access.

3. Explain the Solution Requirements

Only the jump box can connect using SSH to the other VMs while the VMs cannot to each using SSH. In case the VMs connect to each other using SSH, it would mean that the firewall rules are not configured to block the access or if the rules are already in place, it could be a security attack. Further, we would need to review the existing firewalls rules. To verify whether the rules are functional, we would conduct SSH login attempts on all the VMs.

4. Explain the Solution Details

On Azure UI, we can check the settings for the network security groups which lists down the currently set security rules in the network – destination ports, source, and destination. We can attempt SSH logins on all VMs from different IP addresses and between the VMs. We can test the connection for SSH for each VM to check if firewall allows/blocks the connection.

5. Identify Advantages/Disadvantages of the Solution

Since we have created an inbound security rule that Jump box can be only accessed from my personal IP address and other VMs can only be accessed through the jump box, I believe the solution guarantees that the Project 1 network is now "immune" to all unauthorized access.

</details>

---
