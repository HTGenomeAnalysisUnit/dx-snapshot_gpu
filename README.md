# anydocker GPU app

This applet create a machine instance with GPU support and latest NVIDIA drivers and run any bash script you want using a container snapshot.

## Example usage

```bash
dx run /apps/snapshot_gpu_run \
	-isnapshot=project-xxxxxxxxx:/sanpshots/snapshot.tar.gz \
	-iinput_files=project-xxxxxxxxx:/data/input_file1.tsv \
	-iinput_files=project-xxxxxxxxx:/data/input_file2.csv \
	-icmd='echo "This is a test" > /outputs/test_out.txt; ls /inputs >> /outputs/test_out.txt'
```

## Access the data within the app

When running a command in the app:

- input files are available in `/inputs` folder
- output files saved to the `/outputs` folder are automatically uploaded to the configured destination folder in the DNANexus space
- the `dx` command is available in the app, so you can use it to interact with the DNANexus project filesystem if needed

## Inputs

### Mandatory

- `snapshot`: a docker file snapshot generated in DNANexus
- `cmd`: a command string in bash to execute in the container

### Optional

- `input_files`: additional input files
