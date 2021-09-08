cd ~/environment/fiap-cloud-computing-tutorials/
git pull origin master
cd 02-Storage/

export bucket=base-config-<SEU RM>

curl https://perso.telecom-paristech.fr/eagan/class/igr204/data/cereal.csv -o cereal.csv 
curl https://perso.telecom-paristech.fr/eagan/class/igr204/data/cars.csv -o car.csv
curl https://perso.telecom-paristech.fr/eagan/class/igr204/data/factbook.csv -o factbook.csv



aws s3api create-bucket --bucket $bucket --region us-east-1


aws s3 cp car.csv s3://$bucket/car/car.csv

aws s3 cp cereal.csv s3://$bucket/cereal/cereal.csv

aws s3 cp factbook.csv s3://$bucket/factbook/factbook.csv

aws s3 cp factbook.csv s3://$bucket/other/factbook.tst

cd lambda

npm install serverless-pseudo-parameters

sls deploy

sls invoke --function getObject --stage dev --region us-east-1 --path event.json --log

# alterar arquivo para arn:aws:s3:::${self:custom.bucket}/*.tst     arn:aws:s3:::random-bucket-s3-pan/
# {
#     "bucket":"random-bucket-s3-pan",
#     "key": "factbook/factbook.csv"
# }
# {
#     "bucket":"random-bucket-s3-pan",
#     "key": "other/factbook.tst"
# }

sls remove


SELECT * FROM s3object s WHERE s._1 like '%Chevrolet%';

# mudar para glacier o cereal
# tentar acessar


# seguir o s3 performance


aws configure set default.s3.max_concurrent_requests 1  
aws configure set default.s3.multipart_threshold 64MB  
aws configure set default.s3.multipart_chunksize 16MB  


cd ~/environment
mkdir s3-performance
cd s3-performance
export bucket=base-config-<SEU RM>

dd if=/dev/zero of=5GB.file count=5120 bs=1M
time aws s3 cp 5GB.file s3://${bucket}/upload1.test    


aws configure set default.s3.max_concurrent_requests 2  
time aws s3 cp 5GB.file s3://${bucket}/upload2.test  


aws configure set default.s3.max_concurrent_requests 10  
time aws s3 cp 5GB.file s3://${bucket}/upload3.test 

aws configure set default.s3.max_concurrent_requests 20   
time aws s3 cp 5GB.file s3://${bucket}/upload4.test  


dd if=/dev/zero of=1GB.file count=1024 bs=1M

sudo apt-get install parallel -y
time seq 1 5 | parallel --will-cite -j 5 aws s3 cp 1GB.file s3://${bucket}/parallel/object{}.test


#S3 - SYNC COMMAND


mkdir sync
seq -w 1 2000 | xargs -n1 -I% sh -c 'dd if=/dev/zero of=sync/file.% bs=1M count=1'

aws configure set default.s3.max_concurrent_requests 1  
time aws s3 sync sync/ s3://${bucket}/sync1/

aws configure set default.s3.max_concurrent_requests 10  
time aws s3 sync sync/ s3://${bucket}/sync2/

# S3 - OPTIMIZE SMALL FILE OPERATIONS

seq 1 500 > object_ids  
cat object_ids 

dd if=/dev/zero of=1KB.file count=1 bs=1K
time parallel --will-cite -a object_ids -j 5 aws s3 cp 1KB.file s3://${bucket}/run1/{}
time parallel --will-cite -a object_ids -j 15 aws s3 cp 1KB.file s3://${bucket}/run2/{}   
time parallel --will-cite -a object_ids -j 50 aws s3 cp 1KB.file s3://${bucket}/run3/{}
time parallel --will-cite -a object_ids -j 100 aws s3 cp 1KB.file s3://${bucket}/run4/{} 



# S3 - OPTIMIZE COPY OPERATIONS

time (aws s3 cp s3://$bucket/upload1.test 5GB.file; aws s3 cp 5GB.file s3://$bucket/copy/5GB.file)  
time aws s3api copy-object --copy-source $bucket/upload1.test --bucket $bucket --key copy/5GB-2.file
time aws s3 cp s3://$bucket/upload1.test s3://$bucket/copy/5GB-3.file  











