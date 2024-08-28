#KeadData
#!/bin/bash
while IFS= read -r line
do
        echo "Filtering $line"
        time kneaddata --input1 ~/rawdata/oral/oralSeq/${line}_1.fastq.gz --input2 ~/rawdata/oral/oralSeq/${line}_2.fastq.gz --reference-db ~/databases/human_knead  --output 01Knead/ --output-prefix ${line} --trimmomatic ~/miniconda3/envs/kneaddata_env/trim_tools --trimmomatic-options 'SLIDINGWINDOW:4:10 MINLEN:40' --bowtie2-options="--local"
done < sampleid.txt

#Kraken2 and Bracken
while IFS= read -r line
do
        echo "Classifying $line"
        time kraken2 --db ~/databases/krakenDB/specFungiDB --threads 56 --use-names --report ${line}_fungi.kreport2 --paired ~/kneaddata/oral/kneaddataOutput/01Knead/${line}_paired_1.fastq ~/kneaddata/oral/kneaddataOutput/01Knead/${line}_paired_2.fastq --output ${line}_fungi.kraken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l D -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.D.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l P -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.P.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l C -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.C.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l O -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.O.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l F -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.F.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l G -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.G.bracken
        time bracken -d ~/databases/krakenDB/specFungiDB -t 56 -l S -r 150 -i ${line}_fungi.kreport2 -o ${line}_fungi.S.bracken
done < sampleid.txt
