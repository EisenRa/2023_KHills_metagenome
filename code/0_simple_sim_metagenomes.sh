# Creating simple simulated metagneomes
# Raphael Eisenhofer Feb/2023

# Fetch Zymo mock reference genomes:
wget https://zenodo.org/record/3935737/files/ZymoBIOMICS.STD.refseq.v2.zip?download=1
mv ZymoBIOMICS.STD.refseq.v2.zip\?download\=1 ZymoBIOMICS.STD.refseq.v2.zip && unzip ZymoBIOMICS.STD.refseq.v2.zip

# Create simulated metagenomes using https://github.com/merenlab/reads-for-assembly.git
git clone merenlab/reads-for-assembly.git

# Create ANVIO conda environment and load it (https://anvio.org/install/)

# Create the simulated metagenomes:
