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

# add in human DNA
seqtk sample -s 666 Human_reads_3-8M_1.fastq.gz 414169 > Human_reads_414169_1.fastq
seqtk sample -s 666 Human_reads_3-8M_2.fastq.gz 414169 > Human_reads_414169_2.fastq
seqtk sample -s 666 Human_reads_3-8M_1.fastq.gz 207084 > Human_reads_207084_1.fastq
seqtk sample -s 666 Human_reads_3-8M_2.fastq.gz 207084 > Human_reads_207084_2.fastq
seqtk sample -s 666 Human_reads_3-8M_1.fastq.gz 41416 > Human_reads_41416_1.fastq
seqtk sample -s 666 Human_reads_3-8M_2.fastq.gz 41416 > Human_reads_41416_2.fastq

cat sim_meta_zymo_divergent_1-R1.fastq.gz Human_reads_414169_1.fastq.gz > sim_meta_zymo_divergent_1_50pcHost-R1.fastq.gz
cat sim_meta_zymo_divergent_1-R2.fastq.gz Human_reads_414169_2.fastq.gz > sim_meta_zymo_divergent_1_50pcHost-R2.fastq.gz
cat sim_meta_zymo_divergent_1-R1.fastq.gz Human_reads_207084_1.fastq.gz > sim_meta_zymo_divergent_1_33pcHost-R1.fastq.gz
cat sim_meta_zymo_divergent_1-R2.fastq.gz Human_reads_207084_2.fastq.gz > sim_meta_zymo_divergent_1_33pcHost-R2.fastq.gz
cat sim_meta_zymo_divergent_1-R1.fastq.gz Human_reads_41416_1.fastq.gz > sim_meta_zymo_divergent_1_10pcHost-R1.fastq.gz
cat sim_meta_zymo_divergent_1-R2.fastq.gz Human_reads_41416_2.fastq.gz > sim_meta_zymo_divergent_1_10pcHost-R2.fastq.gz

gzip simple_simulated_metagenomes/*.fastq
cp simple_simulated_metagenomes/sim_meta_1a-R1.fastq.gz simple_simulated_metagenomes/sim_meta_1aa-R1.fastq.gz 
cp simple_simulated_metagenomes/sim_meta_1a-R2.fastq.gz simple_simulated_metagenomes/sim_meta_1aa-R2.fastq.gz 
