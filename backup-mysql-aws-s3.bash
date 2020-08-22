#/bin/bash

DATE=$(date +%H-%M-%S)
BACKUP=db-$DATE.sql

DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
AWS_SECRET=$4
BUCKET_NAME=$5
DIR=/tmp/$BUCKET_NAME/
mysqldump -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/$BACKUP && \
export AWS_ACCESS_KEY_ID=pasteyourawsaccesskeyidhere && \
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET && \
echo "uploading your $BACKUP backup" && \
#aws s3 cp /tmp/$BACKUP s3://$BUCKET_NAME/$BACKUP
#Commenting above line since we don't have s3 connection
#Check if directory is already created, if not creating directory before copying.
if [ -d "$DIR" ]; then
 cp /tmp/$BACKUP $DIR/$BACKUP
else
 mkdir $DIR && \
 cp /tmp/$BACKUP $DIR/$BACKUP
fi
