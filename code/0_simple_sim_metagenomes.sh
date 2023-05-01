# Creating simple simulated metagneomes
# Raphael Eisenhofer Feb/2023

# Fetch Zymo mock reference genomes:
mkdir data/simple_sim_metagenomes/genomes && cd data/simple_sim_metagenomes/genomes
wget https://zenodo.org/record/3935737/files/ZymoBIOMICS.STD.refseq.v2.zip?download=1
mv ZymoBIOMICS.STD.refseq.v2.zip\?download\=1 ZymoBIOMICS.STD.refseq.v2.zip && unzip ZymoBIOMICS.STD.refseq.v2.zip
rm ZymoBIOMICS.STD.refseq.v2.zip

# Create simulated metagenomes using https://github.com/merenlab/reads-for-assembly.git
git clone merenlab/reads-for-assembly.git

# Create ANVIO conda environment and load it (https://anvio.org/install/)

# Strain madness dataset: need to remove contigs <390 bp for anvio
for i in source_genomes/*.fasta; do reformat.sh in=$i out=${i/.fasta/_RFD.fasta} minlength=391; done


# Create the simulated metagenomes:
./reads-for-assembly/gen-paired-end-reads ../../../code/simulated_metagenome_profiles/sim_meta_1a.ini
./reads-for-assembly/gen-paired-end-reads ../../../code/simulated_metagenome_profiles/sim_meta_1b.ini
./reads-for-assembly/gen-paired-end-reads ../../../code/simulated_metagenome_profiles/sim_meta_2a.ini
./reads-for-assembly/gen-paired-end-reads ../../../code/simulated_metagenome_profiles/sim_meta_3a.ini

gzip simple_simulated_metagenomes/*.fastq
cp simple_simulated_metagenomes/sim_meta_1a-R1.fastq.gz simple_simulated_metagenomes/sim_meta_1aa-R1.fastq.gz 
cp simple_simulated_metagenomes/sim_meta_1a-R2.fastq.gz simple_simulated_metagenomes/sim_meta_1aa-R2.fastq.gz 
