<!-- dx-header -->
# iva_upload (DNAnexus Platform App)

## What does this app do?
Upload files to Zetta's Azure staging area.

## What are typical use cases for this app?
This app may be executed as a standalone app.

## What data are required for this app to run?
Install azure-cli:
```
curl -sL https://azurecliprod.blob.core.windows.net/$root/deb_install.sh | sudo bash
```
Install azcopy https://azcopyvnext.azureedge.net/release20200818/azcopy_linux_amd64_10.6.0.tar.gz (to check if the upload went through afterwards):
```
tar xvzf azcopy_linux_amd64_${version}.tar.gz
```

You need to login to Azure using:
```
az login
```
This will send you to your browser where you'll login. And boom, logged, then:
- You need a token (SAS) generated using this command:
```
SAS=$(az storage container generate-sas --name stage --expiry $(date -u -d '60 minutes' +%Y-%m-%dT%H:%MZ) --permissions lrw --output tsv --account-name opencgaeglhstage --https-only)
```
- Batch tsv with all the files to upload.

Example cmd line:
```
dx run iva_upload_v1.0.0 -itoken=${SAS} --batch-tsv dx_batch.0000.tsv
```

## What does this app output?
Nothing.

To check if the upload worked you can use:
```
azcopy list 'https://opencgaeglhstage.blob.core.windows.net/stage?'"${SAS}"
```
You might need to regenerate a SAS depending on how long the job took to find a workstation + run.

This is the source code for an app that runs on the DNAnexus Platform.
For more information about how to run or modify it, see
https://documentation.dnanexus.com/.

#### This app was made by EMEE GLH