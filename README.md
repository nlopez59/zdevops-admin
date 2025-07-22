### 🛠️ DBB/VS Code Quick Start Notes (IBM: July 2025)

**Purpose:**
Configure VS Code with DBB, Zowe, and Open Editor to enable mainframe developers to build and test applications using modern DevOps tools.

> Notes: 
- This project has a .vscode/extensions.json file to help install required extensions 
- User settings are defined in .vscode/settings.json.  This is for demo and early testing purposes. Once the configuration is verified, all user's should store personal settings in their local VS Code settings.json file. 

> 🔒 The initial setups are done in 2 phases. The first is performed by the **Z DevOps Admin**, who may need to collaborate with the **z/OS SysProg**, **Security**, and **Network** teams as needed.  The second is to enable a **small** group of developers for further verification and customization using a sample application repo. 

---

## ✅ Prerequisites
* Install **DBB v3** (IDzzE v17 smpe ver) and get the installation path (Typically found in `/usr/lpp/IBM/idz/usr/lpp/IBM/dbb`).
* Define DBB and other environment variables in the **Z DevOps Admin’s** `.profile` in their USS Home Dir. This profile can later be merged into `/etc/profile` for system-wide access.
* Install **RSE API** and get the port (default is 8195)
* Ensure all VS Code users have:

  * an **OMVS RACF segment**
  * a personal **USS home directory**.
  * ability to SSH access into zOS/Unix Systems Services (USS) 
  * Access to clone and push to the enterprise Git repository using SSH or HTTPs from the desktop.
* Install VS Code and the Git extension
* Z DevOps Admin - Clone this repo on their desktop.

>This repo serves as a baseline for the Z DevOps Admin to design, test and save under the enterprise Git server.  This includes both __administrative__ configuration files and a small cobol app for unit testing.  On the other hand, application repos are managed by development teams and do not include administrative files.   Their repo will look like the sample included in the DBB installation folder "/usr/lpp/IBM/dbb/samples/MortgageApplication". 

---

## ⚙️ Phase 1 – Z DevOps Environment Setup (Z DevOps Admin) 

### 1. Configure Zowe

Edit [`zowe.config.json`](zowe.config.json):

* Follow the inline comments and guidance in the sample file.
* Test Zowe access:

  * Open your USS home directory.
  * Create a folder named `dbbworkspace`.

### 2. Import DBB Sample Configuration Files

Open a VS Code terminal and run the following `scp` commands to copy configuration files. Replace `yourID`, `yourHost`, and verify your DBB install path:

> Note: The scp was pre-run and saved in config/build.  But you should refresh with your installed version.
```sh
scp yourID@yourHost:/usr/lpp/IBM/dbb/build/*.yaml                 config/build
scp yourID@yourHost:/usr/lpp/IBM/dbb/samples/languages/*.yaml     config/build
```

### 3. Customize the DBB Language YAML

Open [`Languages.yaml`](config/build/Languages.yaml#63) and:

* Uncomment the required section.
* Set `SIGYCOMP` to your COBOL compiler PDS name.

### 4. Configure VS Code Settings 

Edit [`settings.json`](.vscode/settings.json):

* Set your personal z/OS **HLQ** for PDS allocation:

  ```json
  "dbbHlq": "<your.HLQ>"
  ```
* Set the Zowe **CLI profile** created earlier:

  ```json
  "defaultCliProfile": "<your-profile>"
  ```


### 5. Verify a DBB User Build 
* From VS Code, Commit all changes to this repo and push it to your git server
* On zOS/USS, SSH into your zOS host: 
  * setup Git access from USS to your Git Acct.  Generate SSH Keys for the Z DevOps Admin acct and add the public key to their Git Acct.  
  * clone this repo under Z DevOps Admins home dir
  
* Open the /source/cobol/asample.cbl  file 
* Right click to select "IBM User Build with full upload" from the menu
* Wait for the Build to complete and review the Open Editor terminal output.  
* A **Clean** build message means DBB successfully compiled and linked the sample pgm. 

As the Z DevOps Admin. set up an application repo for developers to test with.  Refer the sample in "/usr/lpp/IBM/dbb/samples/MortgageApplication" 

---

## 🧪 Phase 2 – Developer Lifecycle with VS Code 

* Generate and add your desktop SSH Keys to your Git Server Acct (see you Z Devops Admin for help).
* Clone the sample application repo provided by your Z DevOps Admin.
* Create/modify your VS Code settings.json. Use the sample in ".vscode/settings.json".  Here is an example.  Change the "/u/ibmuser" to your USS Home path. And change the "IBMUSER.VSCODE" HLQ to one you use to allocated new PDSs. 
```
    "zopeneditor.advancedCapabilities.enableRseApiActivationCheck": true,

    "zopeneditor.userbuild.userSettings": {
      "dbbWorkspace": "/u/ibmuser/dbbworkspace",
      "dbbLogDir": "/u/ibmuser/dbbworkspace",
      "dbbHlq": "IBMUSER.VSCODE",
      "dbbDefaultZappProfile": "dbb-userbuild"       
      },
    
    

    "zopeneditor.zowe": {
      "defaultCliProfile": "rse"       
      }
```
* Create a `dbbworkspace` directory in your USS home.


* Checkout a new Git feature branch.
* Modify a COBOL program.
* Right click on the editor and select "IBM User Build with full upload" from the menu

   * `IBM User Build with Full Upload` – to initialize or refresh the `dbb-app.yaml` configuration on USS.
   * Then use `IBM User Build` – for subsequent builds.
* The compiler and linkedit sysout should be in your local /logs folder. 
* A simple batch program can be tested with JCL using the steplib DSN of your DBB HLQ and the LLQ .load
* In VS Code, use Git to Commit and Push your branch to prepare for a Pull Request and Pipeline. 

[Example Dev Flow](https://youtu.be/VvZ5Gg3B2xA)


---

## 🚀 Phase 3 – Run a Pipeline

Run a pipeline using your CI/CD tool (e.g., Jenkins or GitHub Actions) integrated with the DBB project.

---
