Pipeline for variant discovery for '225'-resistant strains of P. falciparum 3D7
Project from Jenny Thompson and Alan Cowman,
Copied from pipeline used Jan-Feb 2017 for 754 data
225 version started May 2017 by Jocelyn Sietsma Penington

Refer to sh/pipeline255.sh 

## Quick HOWTO
1. Create a new empty directory to hold code, scripts and output
2. Clone this repository: `git clone --recursive https://github.com/WEHI-ResearchComputing/resistant-falciparum`. Note the recursive argument to bring in the common tool definitions.
3. Create a toil installation.
    * `virtualenv toil-env`
    * `. toil-env/bin/activate`
    * `pip install toil toil[cwl] cwltool html5lib drmaa`
4. Clone the wehi pipeline add on: `git clone https://github.com/WEHI-ResearchComputing/wehi-pipeline.git`
5. Edit and run the script `resistant-falciparum/src/make-input.py` to build the input file.
6. Copy `resistant-falciparum/src/cwlwehi.py` and edit as appropriate (probably won't need modification).
7. Copy `resistant-falciparum/src/runall.sh` and edit as appropriate
8. Good luck
